import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart' as archive;
import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/data/attachment_files.dart';
import 'package:kepli/domain/models.dart';
import 'package:kepli/services/backup_service.dart';

import '../data/test_support.dart';

void main() {
  late VaultHarness local;
  late VaultHarness remote;
  late BackupService service;

  setUp(() async {
    local = await VaultHarness.create();
    remote = await VaultHarness.create();
    service = BackupService(
      repository: local.repository,
      temporaryDirectory: local.work,
      platform: 'linux',
    );
  });
  tearDown(() async {
    await local.dispose();
    await remote.dispose();
  });

  Future<File> remoteExport({String platform = 'windows'}) => BackupService(
    repository: remote.repository,
    temporaryDirectory: remote.work,
    platform: platform,
  ).exportBackup();

  Future<File> crafted(List<TestZipEntry> entries) =>
      local.source(testZip(entries), suffix: 'zip');

  Future<void> expectRejected(File zip) async {
    final before = await local.repository.load();
    await expectLater(
      service.inspectBackup(zip.path),
      throwsA(isA<KepliException>()),
    );
    final after = await local.repository.load();
    expect(
      after.items.map((item) => item.toJson()),
      before.items.map((item) => item.toJson()),
    );
    expect(after.settings.toJson(), before.settings.toJson());
  }

  test('exports exact schema, platform-independent paths, settings and hashed bytes', () async {
    final item = await local.saveWithPdf(sampleItem());
    final zip = await service.exportBackup();
    expect(
      zip.uri.pathSegments.last,
      matches(r'^kepli-backup-\d{8}-\d{6}\.zip$'),
    );
    final decoded = archive.ZipDecoder().decodeBytes(await zip.readAsBytes());
    final manifest = jsonDecode(
      utf8.decode(decoded.findFile('manifest.json')!.content),
    ) as Map<String, dynamic>;
    expect(manifest['schema_version'], 1);
    expect(manifest['exported_by_platform'], 'linux');
    expect((manifest['exported_at'] as String).endsWith('Z'), isTrue);
    expect(
      manifest['settings'],
      (await local.repository.load()).settings.toJson(),
    );
    expect(manifest['items'], [item.toJson()]);
    expect(
      decoded.files.map((entry) => entry.name),
      everyElement(isNot(contains(r'\'))),
    );
    expect(
      decoded.findFile(item.attachments.single.relativePath)!.content,
      smallPdf,
    );
    final preview = await service.inspectBackup(zip.path);
    expect(preview.conflicts, hasLength(1));
    expect(preview.newItemCount, 0);
    await service.discardPreview(preview);
  });

  for (final platform in ['android', 'ios', 'windows', 'linux', 'macos']) {
    test(
      'schema round trip accepts $platform provenance without physical-path assumptions',
      () async {
        await remote.saveWithPdf(sampleItem());
        final zip = await remoteExport(platform: platform);
        final preview = await service.inspectBackup(zip.path);
        expect(preview.platform, platform);
        expect(preview.newItemCount, 1);
        await service.restore(preview, RestoreMode.replace);
        final restored = (await local.repository.load()).items.single;
        expect(restored.expiryDate.toString(), '2025-02-28');
        expect(restored.attachments.single.relativePath, isNot(contains(r'\')));
        expect(
          await local.repository
              .attachmentFile(restored.attachments.single)
              .readAsBytes(),
          smallPdf,
        );
      },
    );
  }

  test('preview reports shared IDs and does not modify current data', () async {
    final current = await local.saveWithPdf(sampleItem(name: 'Local'));
    await remote.repository.saveItem(
      sampleItem(name: 'Incoming', updatedAt: DateTime.utc(2025)),
    );
    await remote.repository.saveItem(sampleItem(id: secondItemId));
    final preview = await service.inspectBackup((await remoteExport()).path);
    expect(preview.newItemCount, 1);
    expect(preview.conflicts.single.local.name, 'Local');
    expect(preview.conflicts.single.incoming.name, 'Incoming');
    expect(preview.conflicts.single.incomingIsNewer, isTrue);
    expect(
      (await local.repository.load()).items.single.toJson(),
      current.toJson(),
    );
  });

  test('merge is whole-item newest UTC wins, with local settings and category union', () async {
    final old = await local.saveWithPdf(sampleItem(name: 'Local'));
    final oldFile = local.repository.attachmentFile(old.attachments.single);
    await local.repository.saveSettings(
      AppSettings(reminderDays: [10], reminderHour: 8, currency: 'GBP'),
    );
    await remote.repository.saveItem(
      sampleItem(
        name: 'Incoming whole item',
        category: 'Vehicles',
        notes: null,
        updatedAt: DateTime.parse('2024-02-02T23:30:30.123456+13:00'),
      ),
    );
    await remote.repository.saveSettings(
      AppSettings(
        categories: ['Vehicles'],
        reminderDays: [2],
        remindersEnabled: true,
        currency: 'EUR',
      ),
    );
    final preview = await service.inspectBackup((await remoteExport()).path);
    await service.restore(preview, RestoreMode.merge);
    final restored = await local.repository.load();
    expect(restored.items.single.name, 'Incoming whole item');
    expect(restored.items.single.notes, isNull);
    expect(restored.items.single.attachments, isEmpty);
    expect(await oldFile.exists(), isFalse);
    expect(restored.settings.reminderDays, [10]);
    expect(restored.settings.reminderHour, 8);
    expect(restored.settings.currency, 'GBP');
    expect(restored.settings.remindersEnabled, isFalse);
    expect(restored.settings.categories, containsAll(['Tools', 'Vehicles']));
  });

  test('merge ties keep local and explicit keepLocalIds overrides a newer incoming item', () async {
    final original = await local.saveWithPdf(sampleItem(name: 'Keep me'));
    await remote.repository.saveItem(sampleItem(name: 'Same timestamp'));
    final tie = await service.inspectBackup((await remoteExport()).path);
    expect(tie.conflicts.single.incomingIsNewer, isFalse);
    await service.restore(tie, RestoreMode.merge);
    expect(
      (await local.repository.load()).items.single.toJson(),
      original.toJson(),
    );
    await remote.repository.saveItem(
      sampleItem(name: 'Newer', updatedAt: DateTime.utc(2028)),
    );
    final newer = await service.inspectBackup((await remoteExport()).path);
    await service.restore(
      newer,
      RestoreMode.merge,
      keepLocalIds: {firstItemId},
    );
    expect(
      (await local.repository.load()).items.single.toJson(),
      original.toJson(),
    );
  });

  test(
    'merge rechecks live data rather than trusting stale preview conflicts',
    () async {
      await local.repository.saveItem(sampleItem(name: 'Original'));
      await remote.repository.saveItem(
        sampleItem(name: 'Backup', updatedAt: DateTime.utc(2025)),
      );
      final preview = await service.inspectBackup((await remoteExport()).path);
      await local.repository.saveItem(
        sampleItem(name: 'Edited since preview', updatedAt: DateTime.utc(2026)),
      );
      await service.restore(preview, RestoreMode.merge);
      expect(
        (await local.repository.load()).items.single.name,
        'Edited since preview',
      );
    },
  );

  test('idempotent reimport preserves attachment identity and immutable local filename', () async {
    await remote.saveWithPdf(sampleItem());
    final zip = await remoteExport();
    final firstPreview = await service.inspectBackup(zip.path);
    await service.restore(firstPreview, RestoreMode.merge);
    final first = (await local.repository.load()).items.single;
    await service.restore(firstPreview, RestoreMode.merge);
    final secondPreview = await service.inspectBackup(zip.path);
    await service.restore(secondPreview, RestoreMode.merge);
    final finalSnapshot = await local.repository.load();
    expect(finalSnapshot.items, hasLength(1));
    expect(finalSnapshot.items.single.toJson(), first.toJson());
  });

  test('replace restores the complete snapshot and preferences using fresh filenames', () async {
    final original = await local.saveWithPdf(sampleItem());
    final oldFile = local.repository.attachmentFile(
      original.attachments.single,
    );
    final incoming = await remote.saveWithPdf(
      sampleItem(id: secondItemId, category: 'Vehicles'),
    );
    await remote.repository.saveSettings(
      AppSettings(
        categories: ['Vehicles'],
        reminderDays: [5, 2],
        reminderHour: 12,
        remindersEnabled: true,
        currency: 'EUR',
      ),
    );
    final preview = await service.inspectBackup((await remoteExport()).path);
    await service.restore(preview, RestoreMode.replace);
    final snapshot = await local.repository.load();
    expect(snapshot.items.single.id, secondItemId);
    expect(snapshot.settings.toJson(), preview.snapshot.settings.toJson());
    expect(
      snapshot.items.single.attachments.single.relativePath,
      isNot(incoming.attachments.single.relativePath),
    );
    expect(await oldFile.exists(), isFalse);
    expect(
      await local.repository
          .attachmentFile(snapshot.items.single.attachments.single)
          .readAsBytes(),
      smallPdf,
    );
  });

  test(
    'replace SQL failure preserves all current data and receipt bytes',
    () async {
      final original = await local.saveWithPdf(sampleItem());
      await remote.saveWithPdf(
        sampleItem(id: secondItemId, name: 'Reject restore'),
      );
      final preview = await service.inspectBackup((await remoteExport()).path);
      await local.database.customStatement(
        "CREATE TRIGGER reject_restore BEFORE INSERT ON items "
        "WHEN new.name = 'Reject restore' BEGIN SELECT RAISE(ABORT, 'test failure'); END",
      );
      await expectLater(
        service.restore(preview, RestoreMode.replace),
        throwsA(isA<Exception>()),
      );
      expect(
        (await local.repository.load()).items.single.toJson(),
        original.toJson(),
      );
      expect(
        await local.repository
            .attachmentFile(original.attachments.single)
            .readAsBytes(),
        smallPdf,
      );
    },
  );

  test(
    'preview owns an immutable staged copy even if the picked ZIP disappears',
    () async {
      await remote.saveWithPdf(sampleItem());
      final zip = await remoteExport();
      final preview = await service.inspectBackup(zip.path);
      await zip.delete();
      await service.restore(preview, RestoreMode.replace);
      expect((await local.repository.load()).items, hasLength(1));
    },
  );

  test(
    'tampered preview files are reverified before destructive restore',
    () async {
      final original = await local.saveWithPdf(sampleItem());
      await remote.saveWithPdf(sampleItem(id: secondItemId));
      final preview = await service.inspectBackup((await remoteExport()).path);
      final staged =
          await local.work
                  .list(recursive: true)
                  .where(
                    (entry) => entry is File && entry.path.endsWith('.bin'),
                  )
                  .single
              as File;
      await staged.writeAsBytes([...smallPdf, 32]);
      await expectLater(
        service.restore(preview, RestoreMode.replace),
        throwsA(isA<KepliException>()),
      );
      expect(
        (await local.repository.load()).items.single.toJson(),
        original.toJson(),
      );
    },
  );

  test('foreign and discarded previews cannot authorize a restore', () async {
    final preview = await service.inspectBackup((await remoteExport()).path);
    final other = BackupService(
      repository: local.repository,
      temporaryDirectory: local.work,
    );
    await expectLater(
      other.restore(preview, RestoreMode.replace),
      throwsA(isA<KepliException>()),
    );
    await service.discardPreview(preview);
    await service.discardPreview(preview);
    await expectLater(
      service.restore(preview, RestoreMode.replace),
      throwsA(isA<KepliException>()),
    );
    expect(await local.work.list().toList(), isEmpty);
  });

  test('refuses a future schema before any current records change', () async {
    await local.saveWithPdf(sampleItem());
    final zip = await crafted([manifestEntry(backupManifest(schema: 999))]);
    await expectLater(
      service.inspectBackup(zip.path),
      throwsA(
        isA<KepliException>().having(
          (error) => error.message,
          'message',
          contains('newer schema'),
        ),
      ),
    );
    expect((await local.repository.load()).items.single.name, 'Cordless drill');
  });

  test(
    'rejects missing manifest, malformed JSON and non-ZIP reports',
    () async {
      await local.saveWithPdf(sampleItem());
      await expectRejected(await crafted([]));
      await expectRejected(
        await crafted([
          TestZipEntry('manifest.json', utf8.encode('{broken JSON')),
        ]),
      );
      await expectRejected(
        await local.source(
          utf8.encode('Name,Price,Notes\r\nDrill,50,Not a restorable backup'),
          suffix: 'csv',
        ),
      );
    },
  );

  test(
    'rejects invalid UUIDs, missing files, incorrect sizes and SHA-256',
    () async {
      await local.saveWithPdf(sampleItem(name: 'Safe current data'));
      final incoming = await remote.saveWithPdf(sampleItem(id: secondItemId));
      final attachment = incoming.attachments.single;
      await expectRejected(
        await crafted([
          manifestEntry(backupManifest(items: [incoming])),
        ]),
      );
      final invalidId = backupManifest(items: [incoming]);
      (invalidId['items'] as List).first['id'] = 'not-a-uuid';
      await expectRejected(await crafted([manifestEntry(invalidId)]));
      for (final field in ['size', 'sha256']) {
        final invalid = backupManifest(items: [incoming]);
        final metadata =
            ((invalid['items'] as List).first['attachments'] as List).first;
        metadata[field] = field == 'size'
            ? attachment.size + 1
            : List.filled(64, '0').join();
        await expectRejected(
          await crafted([
            manifestEntry(invalid),
            TestZipEntry(attachment.relativePath, smallPdf),
          ]),
        );
      }
    },
  );

  for (final path in [
    '../outside.pdf',
    '/outside.pdf',
    r'C:\outside.pdf',
    r'attachments\..\outside.pdf',
    'attachments/$firstItemId/../../outside.pdf',
    'attachments/$firstItemId/$secondItemId.pdf:alternate',
  ]) {
    test('rejects unsafe ZIP entry "$path"', () async {
      await local.saveWithPdf(sampleItem());
      await expectRejected(
        await crafted([
          manifestEntry(backupManifest()),
          TestZipEntry(path, smallPdf),
        ]),
      );
    });
  }

  test(
    'rejects duplicate names instead of accepting the decoder last-wins view',
    () async {
      await local.saveWithPdf(sampleItem());
      await expectRejected(
        await crafted([
          manifestEntry(backupManifest()),
          manifestEntry(backupManifest(items: [sampleItem(id: secondItemId)])),
        ]),
      );
    },
  );

  test(
    'rejects ZIP symlinks, encryption and conflicting local headers',
    () async {
      await local.saveWithPdf(sampleItem());
      final path = 'attachments/$firstItemId/$secondItemId.pdf';
      for (final malicious in [
        TestZipEntry(path, utf8.encode('../../outside'), mode: 0xa1ff),
        TestZipEntry(path, smallPdf, flags: 1),
        TestZipEntry(path, smallPdf, localName: '../outside.pdf'),
      ]) {
        await expectRejected(
          await crafted([manifestEntry(backupManifest()), malicious]),
        );
      }
    },
  );

  test('checks CRC as well as manifest attachment SHA-256', () async {
    await local.saveWithPdf(sampleItem());
    await expectRejected(
      await crafted([
        TestZipEntry(
          'manifest.json',
          utf8.encode(jsonEncode(backupManifest())),
          crc: 0,
        ),
      ]),
    );
  });

  test('rejects excessive declared sizes before decompression', () async {
    await local.saveWithPdf(sampleItem());
    await expectRejected(
      await crafted([
        manifestEntry(backupManifest()),
        TestZipEntry(
          'attachments/$firstItemId/$secondItemId.pdf',
          smallPdf,
          declaredSize: AttachmentFiles.maxAttachmentBytes + 1,
          deflate: true,
        ),
      ]),
    );
    await expectRejected(
      await crafted([
        TestZipEntry(
          'manifest.json',
          utf8.encode('{}'),
          declaredSize: BackupService.maxManifestBytes + 1,
        ),
      ]),
    );
  });

  test('bounds actual decompressed bytes even when ZIP headers lie', () async {
    await local.saveWithPdf(sampleItem());
    final compressedBomb = TestZipEntry(
      'manifest.json',
      List.filled(2 * 1024 * 1024, 32),
      declaredSize: 1,
      deflate: true,
    );
    await expectRejected(await crafted([compressedBomb]));
  });

  test(
    'rejects unreferenced receipt files instead of silently ignoring them',
    () async {
      await local.saveWithPdf(sampleItem());
      await expectRejected(
        await crafted([
          manifestEntry(backupManifest()),
          TestZipEntry('attachments/$firstItemId/$secondItemId.pdf', smallPdf),
        ]),
      );
    },
  );

  test(
    'accepts valid streamed deflate and validates attachment bytes',
    () async {
      final item = await remote.saveWithPdf(sampleItem());
      final file = await crafted([
        TestZipEntry(
          'manifest.json',
          utf8.encode(jsonEncode(backupManifest(items: [item]))),
          deflate: true,
        ),
        TestZipEntry(
          item.attachments.single.relativePath,
          smallPdf,
          deflate: true,
        ),
      ]);
      final preview = await service.inspectBackup(file.path);
      await service.restore(preview, RestoreMode.merge);
      expect((await local.repository.load()).items.single.name, item.name);
    },
  );

  test('reports missing local files on export but permits a restoring replacement', () async {
    final original = await local.saveWithPdf(sampleItem());
    await local.repository.attachmentFile(original.attachments.single).delete();
    await expectLater(service.exportBackup(), throwsA(isA<KepliException>()));
    await remote.saveWithPdf(sampleItem());
    final preview = await service.inspectBackup((await remoteExport()).path);
    await service.restore(preview, RestoreMode.replace);
    final restored = (await local.repository.load()).items.single;
    expect(
      await local.repository.attachmentFile(restored.attachments.single).readAsBytes(),
      smallPdf,
    );
  });
}
