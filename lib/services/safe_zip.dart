import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:path/path.dart' as p;

import '../data/attachment_files.dart';
import '../domain/models.dart';

/// Defensive bounds applied before and while reading untrusted ZIP backups.
abstract final class ZipLimits {
  static const maxExpandedBytes = 2 * 1024 * 1024 * 1024;
  static const maxArchiveBytes = maxExpandedBytes + 16 * 1024 * 1024;
  static const maxManifestBytes = 16 * 1024 * 1024;
  static const maxEntries = 20000;
  static const maxCentralDirectoryBytes = 8 * 1024 * 1024;
}

/// One validated entry of a backup ZIP.
class ZipEntryInfo {
  ZipEntryInfo({
    required this.name,
    required this.size,
    required this.compressedSize,
    required this.crc,
    required this.method,
    required this.flags,
    required this.localOffset,
  });

  final String name;
  final int size;
  final int compressedSize;
  final int crc;
  final int method;
  final int flags;
  final int localOffset;
  int dataOffset = 0;
  int endOffset = 0;

  bool get isDirectory => name.endsWith('/');
}

/// Preflights central AND local headers before any decompressor is invoked.
/// Archive decoders may collapse duplicate names or eagerly decode symlinks,
/// which makes validation after a general-purpose ZIP decode too late.
class SafeZip {
  SafeZip(this.file);

  final File file;

  Future<List<ZipEntryInfo>> inspect() async {
    final input = await file.open();
    try {
      final length = await input.length();
      final tailStart = math.max(0, length - 65557);
      final tail = await _read(input, tailStart, length - tailStart, length);
      final tailData = ByteData.sublistView(tail);
      var eocd = -1;
      for (var index = tail.length - 22; index >= 0; index--) {
        if (tailData.getUint32(index, Endian.little) == 0x06054b50 &&
            index + 22 + tailData.getUint16(index + 20, Endian.little) ==
                tail.length) {
          eocd = index;
          break;
        }
      }
      if (eocd < 0) {
        throw const KepliException('This is not a complete ZIP file.');
      }
      int end16(int offset) => tailData.getUint16(eocd + offset, Endian.little);
      int end32(int offset) => tailData.getUint32(eocd + offset, Endian.little);
      final count = end16(10);
      final centralSize = end32(12);
      final centralOffset = end32(16);
      if (end16(4) != 0 || end16(6) != 0 || end16(8) != count) {
        throw const KepliException('Split ZIP archives are not supported.');
      }
      if (count == 65535 ||
          centralSize == 0xffffffff ||
          centralOffset == 0xffffffff) {
        throw const KepliException('ZIP64 backups are not supported.');
      }
      if (count > ZipLimits.maxEntries ||
          centralSize > ZipLimits.maxCentralDirectoryBytes ||
          centralOffset + centralSize != tailStart + eocd) {
        throw const KepliException(
          'The ZIP directory is invalid or exceeds safety limits.',
        );
      }
      final central = await _read(input, centralOffset, centralSize, length);
      final data = ByteData.sublistView(central);
      final entries = <ZipEntryInfo>[];
      final names = <String>{};
      var position = 0;
      var expanded = 0;
      for (var index = 0; index < count; index++) {
        if (position + 46 > central.length ||
            data.getUint32(position, Endian.little) != 0x02014b50) {
          throw const KepliException('The ZIP central directory is corrupt.');
        }
        int u16(int offset) => data.getUint16(position + offset, Endian.little);
        int u32(int offset) => data.getUint32(position + offset, Endian.little);
        final nameLength = u16(28);
        final extraLength = u16(30);
        final commentLength = u16(32);
        final recordEnd =
            position + 46 + nameLength + extraLength + commentLength;
        if (recordEnd > central.length || nameLength == 0 || nameLength > 160) {
          throw const KepliException(
            'A ZIP entry has an invalid filename or length.',
          );
        }
        final name = utf8.decode(
          central.sublist(position + 46, position + 46 + nameLength),
        );
        _validateName(name);
        if (!names.add(name.toLowerCase())) {
          throw const KepliException('The ZIP contains duplicate entry names.');
        }
        final mode = (u32(38) >> 16) & 0xf000;
        final directory = name.endsWith('/');
        if (mode == 0xa000 ||
            (mode != 0 && mode != 0x8000 && mode != 0x4000) ||
            (mode == 0x4000 && !directory) ||
            (mode == 0x8000 && directory) ||
            (u32(38) & 0x400) != 0) {
          throw const KepliException(
            'ZIP links and special filesystem entries are not allowed.',
          );
        }
        final flags = u16(8);
        final method = u16(10);
        if (u16(6) > 20 ||
            (flags & ~0x080e) != 0 ||
            u16(34) != 0 ||
            (method != 0 && method != 8)) {
          throw const KepliException(
            'Only unencrypted, single-volume store/deflate ZIP backups are supported.',
          );
        }
        _validateExtra(central, position + 46 + nameLength, extraLength);
        final size = u32(24);
        final compressedSize = u32(20);
        expanded += size;
        final limit = name == 'manifest.json'
            ? ZipLimits.maxManifestBytes
            : AttachmentFiles.maxAttachmentBytes;
        if (size > limit ||
            (directory && size != 0) ||
            expanded > ZipLimits.maxExpandedBytes ||
            compressedSize > ZipLimits.maxArchiveBytes ||
            u32(42) >= centralOffset) {
          throw const KepliException(
            'A ZIP entry exceeds the backup safety limits.',
          );
        }
        entries.add(
          ZipEntryInfo(
            name: name,
            size: size,
            compressedSize: compressedSize,
            crc: u32(16),
            method: method,
            flags: flags,
            localOffset: u32(42),
          ),
        );
        position = recordEnd;
      }
      if (position != central.length) {
        throw const KepliException('Unexpected records in the ZIP directory.');
      }
      for (final entry in entries) {
        final local = await _read(input, entry.localOffset, 30, centralOffset);
        final header = ByteData.sublistView(local);
        int u16(int offset) => header.getUint16(offset, Endian.little);
        int u32(int offset) => header.getUint32(offset, Endian.little);
        if (u32(0) != 0x04034b50 ||
            u16(4) > 20 ||
            u16(6) != entry.flags ||
            u16(8) != entry.method) {
          throw const KepliException(
            'The ZIP local and central headers disagree.',
          );
        }
        final descriptor = (entry.flags & 8) != 0;
        if ((!descriptor &&
                (u32(14) != entry.crc ||
                    u32(18) != entry.compressedSize ||
                    u32(22) != entry.size)) ||
            (descriptor &&
                ((u32(14) != 0 && u32(14) != entry.crc) ||
                    (u32(18) != 0 && u32(18) != entry.compressedSize) ||
                    (u32(22) != 0 && u32(22) != entry.size)))) {
          throw const KepliException('ZIP entry sizes or checksums disagree.');
        }
        final nameLength = u16(26);
        final extraLength = u16(28);
        final fields = await _read(
          input,
          entry.localOffset + 30,
          nameLength + extraLength,
          centralOffset,
        );
        if (utf8.decode(fields.sublist(0, nameLength)) != entry.name) {
          throw const KepliException('The ZIP contains conflicting filenames.');
        }
        _validateExtra(fields, nameLength, extraLength);
        entry.dataOffset = entry.localOffset + 30 + nameLength + extraLength;
        entry.endOffset = entry.dataOffset + entry.compressedSize;
        if (entry.endOffset > centralOffset) {
          throw const KepliException(
            'A ZIP entry is truncated or overlaps its directory.',
          );
        }
        if (descriptor) {
          final first = await _read(input, entry.endOffset, 4, centralOffset);
          final hasSignature =
              ByteData.sublistView(first).getUint32(0, Endian.little) ==
              0x08074b50;
          final offset = entry.endOffset + (hasSignature ? 4 : 0);
          final bytes = await _read(input, offset, 12, centralOffset);
          final descriptorData = ByteData.sublistView(bytes);
          if (descriptorData.getUint32(0, Endian.little) != entry.crc ||
              descriptorData.getUint32(4, Endian.little) !=
                  entry.compressedSize ||
              descriptorData.getUint32(8, Endian.little) != entry.size) {
            throw const KepliException('A ZIP data descriptor is corrupt.');
          }
          entry.endOffset = offset + 12;
        }
      }
      final ordered = [...entries]
        ..sort((a, b) => a.localOffset.compareTo(b.localOffset));
      var expectedOffset = 0;
      for (final entry in ordered) {
        if (entry.localOffset != expectedOffset) {
          throw const KepliException(
            'The ZIP contains overlapping, hidden or unexpected data.',
          );
        }
        expectedOffset = entry.endOffset;
      }
      if (expectedOffset != centralOffset) {
        throw const KepliException(
          'The ZIP contains unexpected data before its directory.',
        );
      }
      return entries;
    } finally {
      await input.close();
    }
  }

  static Future<Uint8List> _read(
    RandomAccessFile input,
    int offset,
    int length,
    int boundary,
  ) async {
    if (offset < 0 || length < 0 || offset + length > boundary) {
      throw const KepliException('The ZIP contains an out-of-bounds entry.');
    }
    await input.setPosition(offset);
    final result = await input.read(length);
    if (result.length != length) {
      throw const KepliException('The ZIP is truncated.');
    }
    return result;
  }

  static void _validateExtra(Uint8List bytes, int offset, int length) {
    final data = ByteData.sublistView(bytes);
    final end = offset + length;
    while (offset < end) {
      if (offset + 4 > end) {
        throw const KepliException('A ZIP extra field is corrupt.');
      }
      final id = data.getUint16(offset, Endian.little);
      final size = data.getUint16(offset + 2, Endian.little);
      if (id == 1 || id == 0x9901) {
        throw const KepliException(
          'ZIP64 and encrypted ZIP entries are not supported.',
        );
      }
      offset += 4 + size;
      if (offset > end) {
        throw const KepliException('A ZIP extra field is truncated.');
      }
    }
  }

  static void _validateName(String name) {
    if (name == 'manifest.json' || name == 'attachments/') return;
    final parts = name.split('/');
    if (parts.length != 3 || parts[0] != 'attachments' || !isUuid(parts[1])) {
      throw const KepliException(
        'The ZIP contains an unsafe or unexpected path.',
      );
    }
    if (parts[2].isEmpty) return;
    if (!RegExp(r'^[a-fA-F0-9-]{36}\.[a-zA-Z0-9]{1,10}$').hasMatch(parts[2]) ||
        !isUuid(p.posix.basenameWithoutExtension(parts[2]))) {
      throw const KepliException('The ZIP contains an unsafe attachment path.');
    }
  }
}
