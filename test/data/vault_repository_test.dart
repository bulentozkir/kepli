import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/data/kepli_database.dart';
import 'package:kepli/data/vault_repository.dart';
import 'package:kepli/domain/models.dart';
import 'package:path/path.dart' as p;

import 'test_support.dart';

void main() {
  late VaultHarness harness;

  setUp(() async => harness = await VaultHarness.create());
  tearDown(() async => harness.dispose());

  test('schema version, defaults and stable installation metadata', () async {
    expect(harness.database.schemaVersion, 1);
    expect((await harness.repository.load()).items, isEmpty);
    final first = await harness.database.select(harness.database.appMeta).get();
    await harness.repository.load();
    final second = await harness.database
        .select(harness.database.appMeta)
        .get();
    expect(
      second.map((row) => '${row.key}:${row.value}'),
      first.map((row) => '${row.key}:${row.value}'),
    );
    expect(
      first.firstWhere((row) => row.key == 'install_id').value,
      matches(RegExp(r'^[a-f0-9-]{36}$')),
    );
  });

  test(
    'round trips exact decimal, calendar date and UTC microseconds',
    () async {
      final original = sampleItem(
        name: 'Café "Drill", XL',
        price: '999999999999.99',
        notes: 'First line\nSecond line',
        updatedAt: DateTime.parse('2024-02-02T23:20:30.123456+13:00'),
      );
      await harness.repository.saveItem(original);
      final loaded = (await harness.repository.load()).items.single;
      expect(loaded.toJson(), original.toJson());
      expect(loaded.updatedAt.isUtc, isTrue);
      expect(loaded.expiryDate.toString(), '2025-02-28');
    },
  );

  test(
    'copies originals into immutable generated paths and hashes copied bytes',
    () async {
      final source = await harness.source(smallPdf);
      await harness.repository.saveItem(
        sampleItem(),
        additions: [
          PendingAttachment(
            sourcePath: source.path,
            originalName: '../../display only.pdf',
            mimeType: 'application/pdf',
          ),
        ],
      );
      final attachment =
          (await harness.repository.load()).items.single.attachments.single;
      expect(attachment.relativePath, startsWith('attachments/$firstItemId/'));
      expect(attachment.relativePath, isNot(contains(r'\')));
      expect(attachment.sha256, sha256.convert(smallPdf).toString());
      await source.writeAsString(
        'The source may change or disappear after import.',
      );
      expect(
        await harness.repository.attachmentFile(attachment).readAsBytes(),
        smallPdf,
      );
      expect(
        (await harness.repository.load()).items.single.attachments,
        hasLength(1),
      );
    },
  );

  test('normalizes category additions consistently', () async {
    await harness.repository.saveItem(sampleItem(category: ' tools '));
    await harness.repository.saveItem(
      sampleItem(id: secondItemId, category: ' Workshop '),
    );
    await harness.repository.saveItem(
      sampleItem(id: secondItemId, category: 'workSHOP'),
    );
    final snapshot = await harness.repository.load();
    expect(snapshot.items.first.category, 'Tools');
    expect(snapshot.items.last.category, 'Workshop');
    expect(
      snapshot.settings.categories.where((value) => value == 'Workshop'),
      hasLength(1),
    );
  });

  test(
    'settings cannot remove used categories but can normalize their spelling',
    () async {
      await harness.repository.saveItem(sampleItem());
      final original = (await harness.repository.load()).settings;
      await expectLater(
        harness.repository.saveSettings(
          original.copyWith(categories: ['Other']),
        ),
        throwsA(isA<KepliException>()),
      );
      expect(
        (await harness.repository.load()).settings.toJson(),
        original.toJson(),
      );
      await harness.repository.saveSettings(
        original.copyWith(categories: [' tools ', 'Other']),
      );
      expect((await harness.repository.load()).items.single.category, 'tools');
    },
  );

  test('rejects unsupported types without changing the item', () async {
    final original = await harness.saveWithPdf(sampleItem());
    final source = await harness.source([1, 2, 3], suffix: 'heic');
    await expectLater(
      harness.repository.saveItem(
        original,
        additions: [
          PendingAttachment(
            sourcePath: source.path,
            originalName: 'photo.heic',
            mimeType: 'image/heic',
          ),
        ],
      ),
      throwsA(
        isA<KepliException>().having(
          (error) => error.message,
          'message',
          contains('Unsupported'),
        ),
      ),
    );
    expect(
      (await harness.repository.load()).items.single.toJson(),
      original.toJson(),
    );
  });

  test(
    'partial copy failure leaves existing database and attachment bytes untouched',
    () async {
      final original = await harness.saveWithPdf(sampleItem());
      final source = await harness.source(smallPdf);
      await expectLater(
        harness.repository.saveItem(
          original,
          additions: [
            PendingAttachment(
              sourcePath: source.path,
              originalName: 'good.pdf',
              mimeType: 'application/pdf',
            ),
            PendingAttachment(
              sourcePath: p.join(harness.base.path, 'missing.pdf'),
              originalName: 'missing.pdf',
              mimeType: 'application/pdf',
            ),
          ],
        ),
        throwsA(isA<KepliException>()),
      );
      expect(
        (await harness.repository.load()).items.single.toJson(),
        original.toJson(),
      );
      final files = await Directory(
        p.join(harness.root.path, 'attachments'),
      ).list(recursive: true).where((file) => file is File).toList();
      expect(files, hasLength(1));
      expect(
        await harness.repository
            .attachmentFile(original.attachments.single)
            .readAsBytes(),
        smallPdf,
      );
    },
  );

  test(
    'delete cascades metadata and only then removes attachment bytes',
    () async {
      final original = await harness.saveWithPdf(sampleItem());
      final file = harness.repository.attachmentFile(
        original.attachments.single,
      );
      await harness.repository.deleteItem(original.id);
      expect((await harness.repository.load()).items, isEmpty);
      expect(
        await harness.database.select(harness.database.attachments).get(),
        isEmpty,
      );
      expect(await file.exists(), isFalse);
    },
  );

  test('foreign keys reject attachment rows with no parent item', () async {
    await expectLater(
      harness.database
          .into(harness.database.attachments)
          .insert(
            AttachmentsCompanion.insert(
              id: secondItemId,
              itemId: firstItemId,
              relativePath: 'attachments/$firstItemId/$secondItemId.pdf',
              originalName: 'receipt.pdf',
              mimeType: 'application/pdf',
              role: 'receipt',
              size: smallPdf.length,
              sha256: sha256.convert(smallPdf).toString(),
              addedAt: DateTime.utc(2024).toIso8601String(),
              position: 0,
            ),
          ),
      throwsA(isA<Exception>()),
    );
  });

  test(
    'replace hash failure cannot delete or overwrite an existing receipt',
    () async {
      final original = await harness.saveWithPdf(sampleItem());
      final attachment = original.attachments.single;
      final file = harness.repository.attachmentFile(attachment);
      final bad = await harness.source([...smallPdf, 32]);
      await expectLater(
        harness.repository.replaceSnapshot(
          VaultSnapshot(items: [original], settings: AppSettings()),
          incomingFiles: {attachment.relativePath: bad.path},
        ),
        throwsA(isA<KepliException>()),
      );
      expect(await file.readAsBytes(), smallPdf);
      expect(
        (await harness.repository.load()).items.single.toJson(),
        original.toJson(),
      );
    },
  );

  test('replace always stages incoming bytes under a fresh filename', () async {
    final original = await harness.saveWithPdf(sampleItem());
    final oldFile = harness.repository.attachmentFile(
      original.attachments.single,
    );
    final incoming = await harness.source(smallPdf);
    await harness.repository.replaceSnapshot(
      VaultSnapshot(items: [original], settings: AppSettings()),
      incomingFiles: {original.attachments.single.relativePath: incoming.path},
    );
    final attachment =
        (await harness.repository.load()).items.single.attachments.single;
    expect(attachment.id, original.attachments.single.id);
    expect(
      attachment.relativePath,
      isNot(original.attachments.single.relativePath),
    );
    expect(
      await harness.repository.attachmentFile(attachment).readAsBytes(),
      smallPdf,
    );
    expect(await oldFile.exists(), isFalse);
  });

  test(
    'transaction failure rolls back both a save and a destructive replacement',
    () async {
      final original = await harness.saveWithPdf(sampleItem());
      final oldFile = harness.repository.attachmentFile(
        original.attachments.single,
      );
      await harness.database.customStatement(
        'CREATE TRIGGER reject_test_item BEFORE INSERT ON items '
        "WHEN new.name = 'Reject transaction' BEGIN SELECT RAISE(ABORT, 'test failure'); END",
      );
      final source = await harness.source(smallPdf);
      await expectLater(
        harness.repository.saveItem(
          sampleItem(
            name: 'Reject transaction',
            attachments: original.attachments,
          ),
          additions: [
            PendingAttachment(
              sourcePath: source.path,
              originalName: 'new.pdf',
              mimeType: 'application/pdf',
            ),
          ],
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        harness.repository.replaceSnapshot(
          VaultSnapshot(
            items: [
              sampleItem(id: secondItemId),
              sampleItem(
                name: 'Reject transaction',
                attachments: original.attachments,
              ),
            ],
            settings: AppSettings(),
          ),
          incomingFiles: {
            original.attachments.single.relativePath: source.path,
          },
        ),
        throwsA(isA<Exception>()),
      );
      expect(
        (await harness.repository.load()).items.single.toJson(),
        original.toJson(),
      );
      expect(await oldFile.readAsBytes(), smallPdf);
    },
  );

  test('does not accept arbitrary or traversal attachment paths', () async {
    final original = await harness.saveWithPdf(sampleItem());
    final attachment = original.attachments.single;
    expect(
      () => harness.repository.attachmentFile(
        attachment.withPath('../../outside.pdf'),
      ),
      throwsA(isA<KepliException>()),
    );
    await expectLater(
      harness.repository.saveItem(
        sampleItem(
          attachments: [
            attachment.withPath('attachments/$firstItemId/$secondItemId.pdf'),
          ],
        ),
      ),
      throwsA(isA<KepliException>()),
    );
    expect(
      (await harness.repository.load()).items.single.toJson(),
      original.toJson(),
    );
  });

  test(
    'snapshot callbacks serialize mutations until attachment reads finish',
    () async {
      final original = await harness.saveWithPdf(sampleItem());
      final started = Completer<void>();
      final release = Completer<void>();
      final exporting = harness.repository.withSnapshot((snapshot) async {
        started.complete();
        await release.future;
        expect(
          await harness.repository
              .attachmentFile(snapshot.items.single.attachments.single)
              .readAsBytes(),
          smallPdf,
        );
      });
      await started.future;
      var deleted = false;
      final deleting = harness.repository
          .deleteItem(original.id)
          .then((_) => deleted = true);
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(deleted, isFalse);
      release.complete();
      await Future.wait([exporting, deleting]);
      expect((await harness.repository.load()).items, isEmpty);
    },
  );

  test(
    'missing receipts do not discard metadata or prevent recovery',
    () async {
      final original = await harness.saveWithPdf(sampleItem());
      await harness.repository
          .attachmentFile(original.attachments.single)
          .delete();
      expect(
        (await harness.repository.load()).items.single.toJson(),
        original.toJson(),
      );
      expect(
        await harness.database.select(harness.database.items).get(),
        hasLength(1),
      );
      final replacement = await harness.source(smallPdf);
      await harness.repository.replaceSnapshot(
        VaultSnapshot(items: [original], settings: AppSettings()),
        incomingFiles: {
          original.attachments.single.relativePath: replacement.path,
        },
      );
      final recovered = (await harness.repository.load()).items.single;
      expect(
        await harness.repository
            .attachmentFile(recovered.attachments.single)
            .readAsBytes(),
        smallPdf,
      );
    },
  );

  test(
    'real SQLite restart preserves settings and files and cleans crash orphans',
    () async {
      final persistent = await VaultHarness.create(persistent: true);
      KepliDatabase? reopenedDatabase;
      VaultRepository? reopened;
      try {
        final original = await persistent.saveWithPdf(sampleItem());
        await persistent.repository.saveSettings(
          AppSettings(
            remindersEnabled: true,
            reminderDays: [14, 2],
            currency: 'EUR',
          ),
        );
        await persistent.repository.close();
        final orphan = File(
          p.join(
            persistent.root.path,
            'attachments',
            firstItemId,
            '$secondItemId.pdf',
          ),
        );
        await orphan.writeAsBytes(smallPdf);
        reopenedDatabase = KepliDatabase(
          NativeDatabase(persistent.databaseFile),
        );
        reopened = VaultRepository(
          database: reopenedDatabase,
          root: persistent.root,
        );
        final snapshot = await reopened.load();
        expect(snapshot.items.single.toJson(), original.toJson());
        expect(snapshot.settings.reminderDays, [14, 2]);
        expect(snapshot.settings.currency, 'EUR');
        expect(await orphan.exists(), isFalse);
        expect(
          await reopened
              .attachmentFile(original.attachments.single)
              .readAsBytes(),
          smallPdf,
        );
      } finally {
        await reopened?.close();
        await persistent.dispose();
      }
    },
  );
}
