import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:archive/archive_io.dart' as archive;
import 'package:path/path.dart' as p;
import 'package:synchronized/synchronized.dart';
import 'package:uuid/uuid.dart';

import '../data/attachment_files.dart';
import '../data/vault_repository.dart';
import '../domain/models.dart';
import 'safe_zip.dart';

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
    required this._owner,
    required this._staging,
    required Map<String, String> files,
  }) : conflicts = List.unmodifiable(conflicts),
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
    required this._repository,
    required Directory temporaryDirectory,
    String? platform,
  }) : _temporaryDirectory = Directory(p.absolute(temporaryDirectory.path)),
       _platform = platform ?? Platform.operatingSystem;

  // Safety limits apply before decompression and to actual streamed output.
  // ZIP64, encryption, split archives and methods other than store/deflate
  // are deliberately unsupported. No full archive is materialized in memory.
  static const maxExpandedBytes = ZipLimits.maxExpandedBytes;
  static const maxArchiveBytes = ZipLimits.maxArchiveBytes;
  static const maxManifestBytes = ZipLimits.maxManifestBytes;
  static const maxEntries = ZipLimits.maxEntries;
  static const maxCentralDirectoryBytes = ZipLimits.maxCentralDirectoryBytes;

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
        'This backup exceeds the safety limits: 2 GiB expanded, '
        '16 MiB manifest or 20,000 ZIP entries.',
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
          await AttachmentFiles.verify(
            _repository.attachmentFile(attachment),
            attachment,
          );
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
          'The ZIP exceeds the 2 GiB plus 16 MiB archive limit.',
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
      final entries = await SafeZip(zip).inspect();
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
      if (error is FormatException) {
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
        'The backup exceeds the 2 GiB or 20,000-entry safety limit.',
      );
    }
  }

  Future<Directory> _newDirectory(String purpose) async {
    final managed = p.join(_repository.root.path, 'attachments');
    if (p.equals(managed, _temporaryDirectory.path) ||
        p.isWithin(managed, _temporaryDirectory.path)) {
      throw const KepliException(
        'Backup staging must be outside the managed attachments directory.',
      );
    }
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
        'The ZIP is empty, invalid or larger than 2 GiB plus 16 MiB.',
      );
    }
    final output = await target.open(mode: FileMode.writeOnly);
    var written = 0;
    try {
      await for (final bytes in source.openRead()) {
        written += bytes.length;
        if (written > maxArchiveBytes) {
          throw const KepliException(
            'The ZIP exceeds the 2 GiB plus 16 MiB archive limit.',
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

  static Stream<List<int>> _compressedChunks(
    File zip,
    ZipEntryInfo entry,
  ) async* {
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

  static Future<void> _extract(
    File zip,
    ZipEntryInfo entry,
    File? target,
  ) async {
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
