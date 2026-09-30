import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:archive/archive_io.dart' as archive;
import 'package:path/path.dart' as p;
import 'package:synchronized/synchronized.dart';
import 'package:uuid/uuid.dart';

import '../data/attachment_files.dart';
import '../data/vault_repository.dart';
import '../domain/models.dart';

class BackupConflict {
  const BackupConflict({required this.local, required this.incoming});

  final WarrantyItem local;
  final WarrantyItem incoming;

  bool get incomingIsNewer =>
      incoming.updatedAt.toUtc().isAfter(local.updatedAt.toUtc());
}

class BackupPreview {
  BackupPreview._({
    required this.snapshot,
    required this.exportedAt,
    required this.platform,
    required List<BackupConflict> conflicts,
    required this.newItemCount,
    required Object owner,
    required Directory staging,
    required Map<String, String> files,
  }) : conflicts = List.unmodifiable(conflicts),
       _owner = owner,
       _staging = staging,
       _files = Map.unmodifiable(files);

  final VaultSnapshot snapshot;
  final DateTime exportedAt;
  final String platform;
  final List<BackupConflict> conflicts;
  final int newItemCount;
  final Object _owner;
  final Directory _staging;
  final Map<String, String> _files;
}

class BackupService {
  BackupService({
    required VaultRepository repository,
    required Directory temporaryDirectory,
    String? platform,
  }) : _repository = repository,
       _temporaryDirectory = Directory(p.absolute(temporaryDirectory.path)),
       _platform = platform ?? Platform.operatingSystem;

  // Safety limits apply before decompression and to actual streamed output.
  // ZIP64, encryption, split archives and methods other than store/deflate
  // are deliberately unsupported. No full archive is materialized in memory.
  static const maxExpandedBytes = 256 * 1024 * 1024;
  static const maxArchiveBytes = 272 * 1024 * 1024;
  static const maxManifestBytes = 4 * 1024 * 1024;
  static const maxEntries = 4096;
  static const maxCentralDirectoryBytes = 2 * 1024 * 1024;

  final VaultRepository _repository;
  final Directory _temporaryDirectory;
  final String _platform;
  final Object _owner = Object();
  final Set<BackupPreview> _previews = {};
  final Lock _previewLock = Lock();

  Future<File> exportBackup() => _repository.withSnapshot((snapshot) async {
    _validateSnapshot(snapshot);
    _validatePlatform(_platform);
    final exportedAt = DateTime.now().toUtc();
    final manifest = utf8.encode(
      jsonEncode({
        'schema_version': 1,
        'exported_at': exportedAt.toIso8601String(),
        'exported_by_platform': _platform,
        'settings': snapshot.settings.toJson(),
        'items': snapshot.items.map((item) => item.toJson()).toList(),
      }),
    );
    final attachments = snapshot.items.expand((item) => item.attachments);
    final total = attachments.fold(
      manifest.length,
      (sum, attachment) => sum + attachment.size,
    );
    if (manifest.length > maxManifestBytes ||
        total > maxExpandedBytes ||
        attachments.length + 1 > maxEntries) {
      throw const KepliException(
        'This backup exceeds the safety limits: 256 MiB expanded, '
        '4 MiB manifest or 4,096 ZIP entries.',
      );
    }
    final directory = await _newDirectory('export');
    final local = exportedAt.toLocal();
    String two(int number) => number.toString().padLeft(2, '0');
    final stamp =
        '${local.year}${two(local.month)}${two(local.day)}-'
        '${two(local.hour)}${two(local.minute)}${two(local.second)}';
    final output = File(p.join(directory.path, 'kepli-backup-$stamp.zip'));
    try {
      final encoder = archive.ZipFileEncoder()..create(output.path);
      try {
        encoder.addArchiveFile(
          archive.ArchiveFile.bytes('manifest.json', manifest),
        );
        for (final attachment in attachments) {
          await encoder.addFile(
            _repository.attachmentFile(attachment),
            attachment.relativePath,
          );
        }
      } finally {
        await encoder.close();
      }
      if (await output.length() > maxArchiveBytes) {
        throw const KepliException(
          'The ZIP exceeds the 272 MiB archive limit.',
        );
      }
      return output;
    } catch (error) {
      await _removeFailedDirectory(directory, error);
      rethrow;
    }
  });

  Future<BackupPreview> inspectBackup(
    String path,
  ) => _previewLock.synchronized(() async {
    final directory = await _newDirectory('inspect');
    try {
      final zip = File(p.join(directory.path, 'source.zip'));
      await _copyArchive(File(path), zip);
      final entries = await _SafeZip(zip).inspect();
      final manifestEntry = entries
          .where((entry) => entry.name == 'manifest.json')
          .firstOrNull;
      if (manifestEntry == null || manifestEntry.isDirectory) {
        throw const KepliException('The backup is missing manifest.json.');
      }
      final manifestFile = File(p.join(directory.path, 'manifest.json'));
      await _extract(zip, manifestEntry, manifestFile);
      final manifest = jsonObject(
        jsonDecode(await manifestFile.readAsString(encoding: utf8)),
        'Manifest',
      );
      final version = jsonInt(manifest, 'schema_version');
      if (version != 1) {
        throw KepliException(
          version > 1
              ? 'This backup uses a newer schema ($version). Update Kepli before restoring it.'
              : 'Unsupported backup schema: $version.',
        );
      }
      final exportedAt = jsonTimestamp(manifest, 'exported_at');
      final platform = jsonString(manifest, 'exported_by_platform');
      _validatePlatform(platform);
      final rawItems = manifest['items'];
      if (rawItems is! List || rawItems.length > maxEntries) {
        throw const KepliException(
          'The backup item list is invalid or too large.',
        );
      }
      final snapshot = VaultSnapshot(
        settings: AppSettings.fromJson(
          jsonObject(manifest['settings'], 'Settings'),
        ),
        items: rawItems
            .map((value) => WarrantyItem.fromJson(jsonObject(value, 'Item')))
            .toList(),
      );
      _validateSnapshot(snapshot);
      final referenced = {
        for (final item in snapshot.items)
          for (final attachment in item.attachments)
            attachment.relativePath: attachment,
      };
      final files = {
        for (final entry in entries)
          if (!entry.isDirectory && entry.name != 'manifest.json')
            entry.name: entry,
      };
      if (files.keys.any((name) => !referenced.containsKey(name))) {
        throw const KepliException(
          'The ZIP contains files not listed in its manifest.',
        );
      }
      final incoming = <String, String>{};
      for (final attachment in referenced.values) {
        final entry = files[attachment.relativePath];
        if (entry == null) {
          throw KepliException(
            'The backup is missing attachment "${attachment.originalName}".',
          );
        }
        if (entry.size != attachment.size) {
          throw KepliException(
            'Attachment "${attachment.originalName}" has an incorrect size.',
          );
        }
        // Flat, generated staging names never reuse untrusted ZIP paths.
        final staged = File(p.join(directory.path, '${const Uuid().v4()}.bin'));
        await _extract(zip, entry, staged);
        await AttachmentFiles.verify(staged, attachment);
        incoming[attachment.relativePath] = staged.path;
      }
      for (final directoryEntry in entries.where(
        (entry) => entry.isDirectory,
      )) {
        await _extract(zip, directoryEntry, null);
      }
      await zip.delete();
      final local = await _repository.load();
      final byId = {
        for (final item in local.items) item.id.toLowerCase(): item,
      };
      final conflicts = <BackupConflict>[];
      var newItems = 0;
      for (final item in snapshot.items) {
        final previous = byId[item.id.toLowerCase()];
        if (previous == null) {
          newItems++;
        } else {
          conflicts.add(BackupConflict(local: previous, incoming: item));
        }
      }
      final preview = BackupPreview._(
        snapshot: snapshot,
        exportedAt: exportedAt,
        platform: platform,
        conflicts: conflicts,
        newItemCount: newItems,
        owner: _owner,
        staging: directory,
        files: incoming,
      );
      _previews.add(preview);
      return preview;
    } catch (error) {
      await _removeFailedDirectory(directory, error);
      if (error is FormatException || error is ZLibException) {
        throw KepliException(
          'The backup is corrupt or has invalid JSON: $error',
        );
      }
      if (error is FileSystemException) {
        throw KepliException('The backup could not be read: ${error.message}.');
      }
      rethrow;
    }
  });

  Future<void> restore(
    BackupPreview preview,
    RestoreMode mode, {
    Set<String> keepLocalIds = const {},
  }) => _previewLock.synchronized(() async {
    _checkPreview(preview);
    _validateSnapshot(preview.snapshot);
    if (keepLocalIds.any((id) => !isUuid(id))) {
      throw const KepliException('Invalid conflict selection.');
    }
    for (final item in preview.snapshot.items) {
      for (final attachment in item.attachments) {
        await AttachmentFiles.verify(
          File(preview._files[attachment.relativePath]!),
          attachment,
        );
      }
    }
    await _repository.withSnapshot((local) async {
      if (mode == RestoreMode.replace) {
        await _repository.replaceSnapshot(
          preview.snapshot,
          incomingFiles: preview._files,
        );
        return;
      }
      final categories = [...local.settings.categories];
      final canonical = {
        for (final category in categories)
          category.trim().toLowerCase(): category,
      };
      for (final category in preview.snapshot.settings.categories) {
        final key = category.trim().toLowerCase();
        if (!canonical.containsKey(key)) {
          canonical[key] = category.trim();
          categories.add(category.trim());
        }
      }
      final items = {
        for (final item in local.items) item.id.toLowerCase(): item,
      };
      final keep = keepLocalIds.map((id) => id.toLowerCase()).toSet();
      final incoming = <String, String>{};
      for (final item in preview.snapshot.items) {
        final id = item.id.toLowerCase();
        final previous = items[id];
        if (previous != null &&
            (keep.contains(id) ||
                !item.updatedAt.toUtc().isAfter(previous.updatedAt.toUtc()))) {
          continue;
        }
        items[id] = item.copyWith(
          category: canonical[item.category.trim().toLowerCase()],
        );
        for (final attachment in item.attachments) {
          incoming[attachment.relativePath] =
              preview._files[attachment.relativePath]!;
        }
      }
      await _repository.replaceSnapshot(
        VaultSnapshot(
          items: items.values.toList(),
          settings: local.settings.copyWith(categories: categories),
        ),
        incomingFiles: incoming,
      );
    });
  });

  Future<void> discardPreview(BackupPreview preview) =>
      _previewLock.synchronized(() async {
        if (!identical(preview._owner, _owner)) {
          throw const KepliException(
            'This backup preview belongs to a different service.',
          );
        }
        if (!_previews.contains(preview)) return;
        await preview._staging.delete(recursive: true);
        _previews.remove(preview);
      });

  void _checkPreview(BackupPreview preview) {
    if (!identical(preview._owner, _owner) || !_previews.contains(preview)) {
      throw const KepliException(
        'This backup preview is no longer valid. Inspect the ZIP again.',
      );
    }
  }

  static void _validatePlatform(String platform) {
    if (!RegExp(r'^[a-z][a-z0-9_-]{0,49}$').hasMatch(platform)) {
      throw const KepliException('The exporting platform is invalid.');
    }
  }

  static void _validateSnapshot(VaultSnapshot snapshot) {
    snapshot.validate();
    final ids = <String>{};
    final attachmentIds = <String>{};
    final paths = <String>{};
    var size = 0;
    for (final item in snapshot.items) {
      if (!ids.add(item.id.toLowerCase())) {
        throw const KepliException(
          'The backup contains duplicate item identifiers.',
        );
      }
      for (final attachment in item.attachments) {
        AttachmentFiles.validateMetadata(attachment, item.id);
        if (!attachmentIds.add(attachment.id.toLowerCase()) ||
            !paths.add(attachment.relativePath.toLowerCase())) {
          throw const KepliException(
            'The backup contains duplicate attachment identifiers or paths.',
          );
        }
        size += attachment.size;
      }
    }
    if (paths.length + 1 > maxEntries || size > maxExpandedBytes) {
      throw const KepliException(
        'The backup exceeds the 256 MiB or 4,096-entry safety limit.',
      );
    }
  }

  Future<Directory> _newDirectory(String purpose) async {
    final type = await FileSystemEntity.type(
      _temporaryDirectory.path,
      followLinks: false,
    );
    if (type != FileSystemEntityType.notFound &&
        type != FileSystemEntityType.directory) {
      throw const KepliException(
        'The backup staging location must be a directory, not a link.',
      );
    }
    await _temporaryDirectory.create(recursive: true);
    final directory = Directory(
      p.join(_temporaryDirectory.path, 'kepli-$purpose-${const Uuid().v4()}'),
    );
    await directory.create();
    return directory;
  }

  static Future<void> _removeFailedDirectory(
    Directory directory,
    Object original,
  ) async {
    try {
      if (await directory.exists()) await directory.delete(recursive: true);
    } on FileSystemException catch (error) {
      throw KepliException(
        '$original Backup staging cleanup also failed: ${error.message}. '
        'Your existing vault has not been replaced.',
      );
    }
  }

  static Future<void> _copyArchive(File source, File target) async {
    if (await FileSystemEntity.type(source.path, followLinks: false) !=
        FileSystemEntityType.file) {
      throw const KepliException('Choose a regular ZIP backup file.');
    }
    final length = await source.length();
    if (length < 22 || length > maxArchiveBytes) {
      throw const KepliException(
        'The ZIP is empty, invalid or larger than 272 MiB.',
      );
    }
    final output = await target.open(mode: FileMode.writeOnly);
    var written = 0;
    try {
      await for (final bytes in source.openRead()) {
        written += bytes.length;
        if (written > maxArchiveBytes) {
          throw const KepliException(
            'The ZIP exceeds the 272 MiB archive limit.',
          );
        }
        await output.writeFrom(bytes);
      }
      if (written != length) {
        throw const KepliException(
          'The backup changed while being copied. Try again.',
        );
      }
      await output.flush();
    } finally {
      await output.close();
    }
  }

  static Stream<List<int>> _compressedChunks(File zip, _ZipEntry entry) async* {
    final input = await zip.open();
    try {
      await input.setPosition(entry.dataOffset);
      var remaining = entry.compressedSize;
      while (remaining > 0) {
        final bytes = await input.read(math.min(8192, remaining));
        if (bytes.isEmpty) throw const KepliException('The ZIP is truncated.');
        remaining -= bytes.length;
        yield bytes;
      }
    } finally {
      await input.close();
    }
  }

  static Future<void> _extract(File zip, _ZipEntry entry, File? target) async {
    final output = target == null
        ? null
        : await target.open(mode: FileMode.writeOnly);
    var count = 0;
    var crc = 0;
    Stream<List<int>> bytes = _compressedChunks(zip, entry);
    if (entry.method == 8) bytes = bytes.transform(ZLibDecoder(raw: true));
    try {
      await for (final chunk in bytes) {
        count += chunk.length;
        if (count > entry.size) {
          throw KepliException(
            'ZIP entry "${entry.name}" exceeds its declared size.',
          );
        }
        crc = archive.getCrc32(chunk, crc);
        if (output != null) await output.writeFrom(chunk);
      }
      if (count != entry.size || crc != entry.crc) {
        throw KepliException(
          'ZIP entry "${entry.name}" failed its size or CRC check.',
        );
      }
      if (output != null) await output.flush();
    } finally {
      await output?.close();
    }
  }
}

class _ZipEntry {
  _ZipEntry({
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
class _SafeZip {
  _SafeZip(this.file);

  final File file;

  Future<List<_ZipEntry>> inspect() async {
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
      if (eocd < 0)
        throw const KepliException('This is not a complete ZIP file.');
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
      if (count > BackupService.maxEntries ||
          centralSize > BackupService.maxCentralDirectoryBytes ||
          centralOffset + centralSize != tailStart + eocd) {
        throw const KepliException(
          'The ZIP directory is invalid or exceeds safety limits.',
        );
      }
      final central = await _read(input, centralOffset, centralSize, length);
      final data = ByteData.sublistView(central);
      final entries = <_ZipEntry>[];
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
            ? BackupService.maxManifestBytes
            : AttachmentFiles.maxAttachmentBytes;
        if (size > limit ||
            (directory && size != 0) ||
            expanded > BackupService.maxExpandedBytes ||
            compressedSize > BackupService.maxArchiveBytes ||
            u32(42) >= centralOffset) {
          throw const KepliException(
            'A ZIP entry exceeds the backup safety limits.',
          );
        }
        entries.add(
          _ZipEntry(
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
    if (result.length != length)
      throw const KepliException('The ZIP is truncated.');
    return result;
  }

  static void _validateExtra(Uint8List bytes, int offset, int length) {
    final data = ByteData.sublistView(bytes);
    final end = offset + length;
    while (offset < end) {
      if (offset + 4 > end)
        throw const KepliException('A ZIP extra field is corrupt.');
      final id = data.getUint16(offset, Endian.little);
      final size = data.getUint16(offset + 2, Endian.little);
      if (id == 1 || id == 0x9901) {
        throw const KepliException(
          'ZIP64 and encrypted ZIP entries are not supported.',
        );
      }
      offset += 4 + size;
      if (offset > end)
        throw const KepliException('A ZIP extra field is truncated.');
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
