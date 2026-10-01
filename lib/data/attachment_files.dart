import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import '../domain/models.dart';

class AttachmentDigest {
  const AttachmentDigest(this.size, this.sha256);

  final int size;
  final String sha256;
}

/// The same conservative file policy is used for imports, restores and exports.
abstract final class AttachmentFiles {
  static const maxAttachmentBytes = 256 * 1024 * 1024;
  static const extensions = <String, List<String>>{
    'image/jpeg': ['jpg', 'jpeg'],
    'image/png': ['png'],
    'image/gif': ['gif'],
    'image/webp': ['webp'],
    'image/bmp': ['bmp'],
    'application/pdf': ['pdf'],
  };

  static String extensionFor(String mimeType) {
    final values = extensions[mimeType];
    if (values == null) {
      throw KepliException(
        'Unsupported attachment type "$mimeType". '
        'Use JPEG, PNG, GIF, WebP, BMP or PDF; convert other formats first.',
      );
    }
    return values.first;
  }

  static void validateMetadata(WarrantyAttachment attachment, String itemId) {
    attachment.validate(itemId);
    final parts = _pathParts(attachment.relativePath);
    final extension = p.posix.extension(parts.last).substring(1).toLowerCase();
    extensionFor(attachment.mimeType);
    if (!extensions[attachment.mimeType]!.contains(extension) ||
        attachment.size <= 0 ||
        attachment.size > maxAttachmentBytes) {
      throw KepliException(
        'Invalid attachment "${attachment.originalName}". '
        'Its format must match its extension and its size must be 1 byte to 256 MiB.',
      );
    }
  }

  static List<String> _pathParts(String relativePath) {
    final parts = relativePath.split('/');
    if (parts.length != 3 ||
        parts.first != 'attachments' ||
        !isUuid(parts[1]) ||
        !RegExp(
          r'^[0-9a-fA-F-]{36}\.[a-zA-Z0-9]{1,10}$',
        ).hasMatch(parts.last) ||
        !isUuid(p.posix.basenameWithoutExtension(parts.last))) {
      throw const KepliException('An attachment has an unsafe file path.');
    }
    return parts;
  }

  static File file(Directory root, String relativePath) {
    final parts = _pathParts(relativePath);
    var current = p.normalize(p.absolute(root.path));
    _checkDirectory(current);
    for (final part in parts.take(parts.length - 1)) {
      current = p.join(current, part);
      _checkDirectory(current);
    }
    final result = File(p.join(current, parts.last));
    final type = FileSystemEntity.typeSync(result.path, followLinks: false);
    if (type != FileSystemEntityType.notFound &&
        type != FileSystemEntityType.file) {
      throw const KepliException(
        'Attachment files must not be links or directories.',
      );
    }
    return result;
  }

  static void _checkDirectory(String path) {
    final type = FileSystemEntity.typeSync(path, followLinks: false);
    if (type != FileSystemEntityType.notFound &&
        type != FileSystemEntityType.directory) {
      throw const KepliException(
        'The attachment directory must not contain filesystem links.',
      );
    }
  }

  static Future<void> initialize(Directory root) async {
    _checkDirectory(root.path);
    await root.create(recursive: true);
    final directory = Directory(p.join(root.path, 'attachments'));
    _checkDirectory(directory.path);
    await directory.create();
  }

  static Future<File> create(
    Directory root,
    String itemId,
    String mimeType,
  ) async {
    if (!isUuid(itemId)) {
      throw const KepliException('Invalid item identifier for an attachment.');
    }
    final extension = extensionFor(mimeType);
    final directory = Directory(p.join(root.path, 'attachments', itemId));
    _checkDirectory(root.path);
    _checkDirectory(p.join(root.path, 'attachments'));
    _checkDirectory(directory.path);
    await directory.create();
    final relativePath = 'attachments/$itemId/${const Uuid().v4()}.$extension';
    final target = file(root, relativePath);
    await target.create(exclusive: true);
    return target;
  }

  static String relativePath(Directory root, File file) =>
      p.split(p.relative(file.path, from: root.path)).join('/');

  static Future<AttachmentDigest> copy({
    required File source,
    required File target,
    required String mimeType,
    WarrantyAttachment? expected,
  }) async {
    final output = await target.open(mode: FileMode.writeOnly);
    try {
      final digest = await _digest(source, mimeType, output: output);
      _compare(digest, expected);
      await output.flush();
      return digest;
    } finally {
      await output.close();
    }
  }

  static Future<void> verify(File source, WarrantyAttachment expected) async {
    final digest = await _digest(source, expected.mimeType);
    _compare(digest, expected);
  }

  static void _compare(AttachmentDigest digest, WarrantyAttachment? expected) {
    if (expected != null &&
        (digest.size != expected.size || digest.sha256 != expected.sha256)) {
      throw KepliException(
        'Attachment "${expected.originalName}" failed its size or SHA-256 '
        'integrity check. No existing attachment was changed.',
      );
    }
  }

  static Future<AttachmentDigest> _digest(
    File source,
    String mimeType, {
    RandomAccessFile? output,
  }) async {
    extensionFor(mimeType);
    if (await FileSystemEntity.type(source.path, followLinks: false) !=
        FileSystemEntityType.file) {
      throw KepliException(
        'Attachment "${p.basename(source.path)}" is missing or is not a regular file.',
      );
    }
    final length = await source.length();
    if (length <= 0 || length > maxAttachmentBytes) {
      throw const KepliException(
        'Attachments must be between 1 byte and 256 MiB.',
      );
    }
    final digestSink = _DigestSink();
    final hasher = crypto.sha256.startChunkedConversion(digestSink);
    final header = <int>[];
    var count = 0;
    try {
      await for (final bytes in source.openRead()) {
        count += bytes.length;
        if (count > maxAttachmentBytes) {
          throw const KepliException(
            'An attachment exceeds the 256 MiB limit.',
          );
        }
        if (header.length < 16) {
          header.addAll(bytes.take(16 - header.length));
        }
        hasher.add(bytes);
        if (output != null) await output.writeFrom(bytes);
      }
    } finally {
      hasher.close();
    }
    if (count != length || !_matchesHeader(header, mimeType)) {
      throw KepliException(
        'Attachment "${p.basename(source.path)}" changed while being read '
        'or does not contain a valid $mimeType file.',
      );
    }
    return AttachmentDigest(count, digestSink.value!.toString());
  }

  static bool _matchesHeader(List<int> bytes, String mimeType) {
    bool starts(List<int> signature, [int offset = 0]) {
      if (bytes.length < signature.length + offset) return false;
      for (var i = 0; i < signature.length; i++) {
        if (bytes[i + offset] != signature[i]) return false;
      }
      return true;
    }

    return switch (mimeType) {
      'image/jpeg' => starts([0xff, 0xd8, 0xff]),
      'image/png' => starts([0x89, 0x50, 0x4e, 0x47, 13, 10, 26, 10]),
      'image/gif' => starts('GIF87a'.codeUnits) || starts('GIF89a'.codeUnits),
      'image/webp' => starts('RIFF'.codeUnits) && starts('WEBP'.codeUnits, 8),
      'image/bmp' => starts('BM'.codeUnits),
      'application/pdf' => starts('%PDF-'.codeUnits),
      _ => false,
    };
  }
}

class _DigestSink implements Sink<crypto.Digest> {
  crypto.Digest? value;

  @override
  void add(crypto.Digest data) => value = data;

  @override
  void close() {}
}
