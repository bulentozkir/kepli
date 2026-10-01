import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:synchronized/synchronized.dart';
import 'package:uuid/uuid.dart';

import '../domain/models.dart';
import 'attachment_files.dart';
import 'kepli_database.dart';

/// A mutation succeeded; only deletion of unreferenced files needs retrying.
class VaultCleanupException extends KepliException {
  const VaultCleanupException(super.message);

  bool get dataCommitted => true;
}

class VaultRepository {
  VaultRepository({required this._database, required Directory root})
    : root = Directory(p.normalize(p.absolute(root.path)));

  final KepliDatabase _database;
  final Directory root;
  final Lock _lock = Lock(reentrant: true);
  bool _initialized = false;
  bool _closed = false;

  Future<VaultSnapshot> load() => withSnapshot((snapshot) async => snapshot);

  /// Keeps both metadata and immutable attachment files stable for the callback.
  /// Reentrancy also lets restores select their merge winners and commit under
  /// the same lock, rather than act on an out-of-date preview.
  Future<T> withSnapshot<T>(Future<T> Function(VaultSnapshot) action) =>
      _lock.synchronized(() async {
        await _initialize();
        final snapshot = await _readSnapshot();
        return action(snapshot);
      });

  File attachmentFile(WarrantyAttachment attachment) =>
      AttachmentFiles.file(root, attachment.relativePath);

  Future<void> saveItem(
    WarrantyItem item, {
    List<PendingAttachment> additions = const [],
  }) => _lock.synchronized(() async {
    await _initialize();
    item.validate();
    for (final addition in additions) {
      AttachmentFiles.extensionFor(addition.mimeType);
      if (addition.originalName.trim().isEmpty ||
          addition.originalName.length > 255) {
        throw const KepliException(
          'An attachment needs a valid original name.',
        );
      }
    }
    final current = await _readSnapshot();
    final currentItem = current.items
        .where((entry) => entry.id == item.id)
        .firstOrNull;
    final known = {
      for (final attachment
          in currentItem?.attachments ?? <WarrantyAttachment>[])
        attachment.id: attachment,
    };
    for (final attachment in item.attachments) {
      final old = known[attachment.id];
      if (old == null || !_sameFile(old, attachment)) {
        throw const KepliException(
          'New attachment files must be imported, not linked by filename.',
        );
      }
      AttachmentFiles.validateMetadata(attachment, item.id);
      await AttachmentFiles.verify(attachmentFile(attachment), attachment);
    }
    final categories = [...current.settings.categories];
    final category = _category(item.category, categories, allowNew: true);
    var updated = item.copyWith(category: category);
    final settings = current.settings.copyWith(categories: categories);
    _validate(
      VaultSnapshot(
        items: [
          ...current.items.where((entry) => entry.id != item.id),
          updated,
        ],
        settings: settings,
      ),
    );
    final created = <File>[];
    try {
      final attachments = [...item.attachments];
      for (final addition in additions) {
        final target = await AttachmentFiles.create(
          root,
          item.id,
          addition.mimeType,
        );
        created.add(target);
        final digest = await AttachmentFiles.copy(
          source: File(addition.sourcePath),
          target: target,
          mimeType: addition.mimeType,
        );
        attachments.add(
          WarrantyAttachment(
            id: const Uuid().v4(),
            relativePath: AttachmentFiles.relativePath(root, target),
            originalName: addition.originalName,
            mimeType: addition.mimeType,
            role: addition.role,
            size: digest.size,
            sha256: digest.sha256,
            addedAt: DateTime.now().toUtc(),
          ),
        );
      }
      updated = updated.copyWith(attachments: attachments);
      final next = VaultSnapshot(
        items: [
          ...current.items.where((entry) => entry.id != item.id),
          updated,
        ],
        settings: settings,
      );
      _validate(next);
      await _database.transaction(() async {
        await _writeSettings(settings);
        await _writeItem(updated);
      });
    } catch (error) {
      await _removeUncommitted(created, error);
      rethrow;
    }
    await _cleanupCommitted();
  });

  Future<void> deleteItem(String id) => _lock.synchronized(() async {
    await _initialize();
    if (!isUuid(id)) {
      throw const KepliException('Invalid warranty identifier.');
    }
    await _database.transaction(() async {
      await (_database.delete(
        _database.items,
      )..where((row) => row.id.equals(id))).go();
    });
    await _cleanupCommitted();
  });

  Future<void> saveSettings(AppSettings settings) =>
      _lock.synchronized(() async {
        await _initialize();
        final current = await _readSnapshot();
        final normalized = settings.copyWith(
          categories: settings.categories.map((value) => value.trim()).toList(),
        );
        normalized.validate();
        final categories = [...normalized.categories];
        final items = current.items
            .map(
              (item) => item.copyWith(
                category: _category(item.category, categories, allowNew: false),
              ),
            )
            .toList();
        _validate(VaultSnapshot(items: items, settings: normalized));
        await _database.transaction(() async {
          await _writeSettings(normalized);
          for (final item in items) {
            await (_database.update(_database.items)
                  ..where((row) => row.id.equals(item.id)))
                .write(ItemsCompanion(category: Value(item.category)));
          }
        });
      });

  Future<void> replaceSnapshot(
    VaultSnapshot snapshot, {
    Map<String, String> incomingFiles = const {},
  }) => _lock.synchronized(() async {
    await _initialize();
    snapshot = _normalize(snapshot);
    _validate(snapshot);
    final incomingPaths = {
      for (final item in snapshot.items)
        for (final attachment in item.attachments) attachment.relativePath,
    };
    if (incomingFiles.keys.any((path) => !incomingPaths.contains(path))) {
      throw const KepliException('The restore contains unreferenced files.');
    }
    final current = await _readSnapshot();
    final known = {
      for (final item in current.items)
        for (final attachment in item.attachments)
          attachment.relativePath: attachment,
    };
    final created = <File>[];
    final nextItems = <WarrantyItem>[];
    try {
      for (final item in snapshot.items) {
        final nextAttachments = <WarrantyAttachment>[];
        for (final attachment in item.attachments) {
          final sourcePath = incomingFiles[attachment.relativePath];
          if (sourcePath == null) {
            final old = known[attachment.relativePath];
            if (old == null || !_sameFile(old, attachment)) {
              throw KepliException(
                'The file for "${attachment.originalName}" is missing from the restore.',
              );
            }
            await AttachmentFiles.verify(attachmentFile(old), attachment);
            nextAttachments.add(attachment);
          } else {
            final target = await AttachmentFiles.create(
              root,
              item.id,
              attachment.mimeType,
            );
            created.add(target);
            await AttachmentFiles.copy(
              source: File(sourcePath),
              target: target,
              mimeType: attachment.mimeType,
              expected: attachment,
            );
            nextAttachments.add(
              attachment.withPath(AttachmentFiles.relativePath(root, target)),
            );
          }
        }
        nextItems.add(item.copyWith(attachments: nextAttachments));
      }
      final next = VaultSnapshot(items: nextItems, settings: snapshot.settings);
      _validate(next);
      await _database.transaction(() async {
        await _database.delete(_database.attachments).go();
        await _database.delete(_database.items).go();
        await _writeSettings(next.settings);
        for (final item in next.items) {
          await _writeItem(item);
        }
      });
    } catch (error) {
      await _removeUncommitted(created, error);
      rethrow;
    }
    await _cleanupCommitted();
  });

  Future<void> close() => _lock.synchronized(() async {
    if (_closed) return;
    _closed = true;
    await _database.close();
  });

  Future<void> _initialize() async {
    if (_closed) throw StateError('The vault is closed.');
    if (_initialized) return;
    await AttachmentFiles.initialize(root);
    await _database.transaction(() async {
      final settings = await (_database.select(
        _database.appMeta,
      )..where((row) => row.key.equals('settings'))).getSingleOrNull();
      if (settings == null) await _writeSettings(AppSettings());
      for (final entry in {
        'schema_version': '1',
        'install_id': const Uuid().v4(),
      }.entries) {
        await _database
            .into(_database.appMeta)
            .insert(
              AppMetaCompanion.insert(key: entry.key, value: entry.value),
              mode: InsertMode.insertOrIgnore,
            );
      }
    });
    await _readSnapshot();
    _initialized = true;
    await _cleanupCommitted();
  }

  Future<VaultSnapshot> _readSnapshot() => _database.transaction(() async {
    final storedSettings = await (_database.select(
      _database.appMeta,
    )..where((row) => row.key.equals('settings'))).getSingle();
    final settings = AppSettings.fromJson(
      jsonObject(jsonDecode(storedSettings.value), 'Settings'),
    );
    final itemRows = await (_database.select(
      _database.items,
    )..orderBy([(row) => OrderingTerm.asc(row.id)])).get();
    final attachmentRows = await (_database.select(
      _database.attachments,
    )..orderBy([(row) => OrderingTerm.asc(row.position)])).get();
    final grouped = <String, List<WarrantyAttachment>>{};
    for (final row in attachmentRows) {
      if (row.role != 'receipt' && row.role != 'product') {
        throw const KepliException('A saved attachment has an invalid role.');
      }
      (grouped[row.itemId] ??= []).add(
        WarrantyAttachment(
          id: row.id,
          relativePath: row.relativePath,
          originalName: row.originalName,
          mimeType: row.mimeType,
          role: AttachmentRole.values.byName(row.role),
          size: row.size,
          sha256: row.sha256,
          addedAt: DateTime.parse(row.addedAt).toUtc(),
        ),
      );
    }
    final itemIds = itemRows.map((row) => row.id).toSet();
    if (grouped.keys.any((id) => !itemIds.contains(id))) {
      throw const KepliException('The database contains an orphan attachment.');
    }
    final snapshot = VaultSnapshot(
      items: itemRows
          .map(
            (row) => WarrantyItem(
              id: row.id,
              name: row.name,
              category: row.category,
              purchaseDate: CalendarDate.parse(row.purchaseDate),
              warrantyLengthMonths: row.warrantyLengthMonths,
              price: row.price,
              currency: row.currency,
              vendor: row.vendor,
              notes: row.notes,
              claimed: row.claimed,
              createdAt: DateTime.parse(row.createdAt).toUtc(),
              updatedAt: DateTime.parse(row.updatedAt).toUtc(),
              attachments: grouped[row.id] ?? const [],
            ),
          )
          .toList(),
      settings: settings,
    );
    _validate(snapshot);
    return snapshot;
  });

  Future<void> _writeSettings(AppSettings settings) => _database
      .into(_database.appMeta)
      .insertOnConflictUpdate(
        AppMetaCompanion.insert(
          key: 'settings',
          value: jsonEncode(settings.toJson()),
        ),
      )
      .then((_) {});

  Future<void> _writeItem(WarrantyItem item) async {
    await _database
        .into(_database.items)
        .insertOnConflictUpdate(
          ItemsCompanion.insert(
            id: item.id,
            name: item.name,
            category: item.category,
            purchaseDate: item.purchaseDate.toString(),
            warrantyLengthMonths: item.warrantyLengthMonths,
            price: Value(item.price),
            currency: item.currency,
            vendor: Value(item.vendor),
            notes: Value(item.notes),
            claimed: Value(item.claimed),
            createdAt: item.createdAt.toUtc().toIso8601String(),
            updatedAt: item.updatedAt.toUtc().toIso8601String(),
          ),
        );
    await (_database.delete(
      _database.attachments,
    )..where((row) => row.itemId.equals(item.id))).go();
    for (var index = 0; index < item.attachments.length; index++) {
      final attachment = item.attachments[index];
      await _database
          .into(_database.attachments)
          .insert(
            AttachmentsCompanion.insert(
              id: attachment.id,
              itemId: item.id,
              relativePath: attachment.relativePath,
              originalName: attachment.originalName,
              mimeType: attachment.mimeType,
              role: attachment.role.name,
              size: attachment.size,
              sha256: attachment.sha256,
              addedAt: attachment.addedAt.toUtc().toIso8601String(),
              position: index,
            ),
          );
    }
  }

  static bool _sameFile(WarrantyAttachment a, WarrantyAttachment b) =>
      a.id == b.id &&
      a.relativePath == b.relativePath &&
      a.mimeType == b.mimeType &&
      a.size == b.size &&
      a.sha256 == b.sha256;

  static String _category(
    String value,
    List<String> categories, {
    required bool allowNew,
  }) {
    final trimmed = value.trim();
    for (final category in categories) {
      if (category.toLowerCase() == trimmed.toLowerCase()) return category;
    }
    if (!allowNew) {
      throw KepliException('Category "$trimmed" is still used by a warranty.');
    }
    categories.add(trimmed);
    return trimmed;
  }

  static VaultSnapshot _normalize(VaultSnapshot snapshot) {
    final categories = snapshot.settings.categories
        .map((value) => value.trim())
        .toList();
    return VaultSnapshot(
      settings: snapshot.settings.copyWith(categories: categories),
      items: snapshot.items
          .map(
            (item) => item.copyWith(
              category: _category(item.category, categories, allowNew: false),
            ),
          )
          .toList(),
    );
  }

  static void _validate(VaultSnapshot snapshot) {
    snapshot.validate();
    final ids = <String>{};
    final attachmentIds = <String>{};
    final paths = <String>{};
    for (final item in snapshot.items) {
      if (!ids.add(item.id.toLowerCase())) {
        throw const KepliException(
          'Item identifiers must also be unique ignoring case.',
        );
      }
      for (final attachment in item.attachments) {
        AttachmentFiles.validateMetadata(attachment, item.id);
        if (!attachmentIds.add(attachment.id.toLowerCase()) ||
            !paths.add(attachment.relativePath.toLowerCase())) {
          throw const KepliException(
            'Attachment identifiers and paths must be unique ignoring case.',
          );
        }
      }
    }
  }

  Future<void> _removeUncommitted(List<File> created, Object original) async {
    try {
      for (final file in created) {
        if (await file.exists()) await file.delete();
      }
    } on FileSystemException catch (error) {
      throw KepliException(
        '$original No existing data was changed, but unused staging files '
        'could not be removed: ${error.message}. Restart to retry cleanup.',
      );
    }
  }

  Future<void> _cleanupCommitted() async {
    try {
      final snapshot = await _readSnapshot();
      final referenced = {
        for (final item in snapshot.items)
          for (final attachment in item.attachments)
            attachment.relativePath.toLowerCase(),
      };
      final attachments = Directory(p.join(root.path, 'attachments'));
      if (await FileSystemEntity.type(attachments.path, followLinks: false) !=
          FileSystemEntityType.directory) {
        throw const FileSystemException(
          'The attachments directory is not a directory.',
        );
      }
      final directories = <Directory>[];
      await for (final entity in attachments.list(
        recursive: true,
        followLinks: false,
      )) {
        if (entity is Directory) {
          directories.add(entity);
        } else {
          final relative = p
              .split(p.relative(entity.path, from: root.path))
              .join('/')
              .toLowerCase();
          if (!referenced.contains(relative)) await entity.delete();
        }
      }
      directories.sort((a, b) => b.path.length.compareTo(a.path.length));
      for (final directory in directories) {
        if (await directory.list(followLinks: false).isEmpty) {
          await directory.delete();
        }
      }
    } on FileSystemException catch (error) {
      throw VaultCleanupException(
        'Your vault changes are saved, but unused attachment files could not '
        'be removed: ${error.message}. Restart to retry cleanup.',
      );
    }
  }
}
