import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/data/kepli_database.dart';
import 'package:kepli/data/vault_repository.dart';
import 'package:kepli/domain/models.dart';
import 'package:kepli/services/backup_service.dart';

import 'test_support.dart';

const salesId = 'aaaaaaaa-1111-4111-8111-111111111111';
const serviceId = 'bbbbbbbb-2222-4222-8222-222222222222';
const contacts = [
  ItemContact(
    id: salesId,
    role: ContactRole.sales,
    name: 'Sales representative',
    organization: 'Local Store',
    phone: '+1 555 0111',
  ),
  ItemContact(
    id: serviceId,
    role: ContactRole.service,
    name: 'Repair specialist',
    organization: 'Service Company',
    email: 'repairs@example.test',
    notes: 'Call before visiting.',
  ),
];

void main() {
  late VaultHarness source;
  setUp(() async => source = await VaultHarness.create(persistent: true));
  tearDown(() async => source.dispose());

  Future<WarrantyItem> saveContacts() async {
    final file = await source.source(smallPdf);
    await source.repository.saveItem(
      sampleItem(contacts: contacts),
      additions: [
        PendingAttachment(
          sourcePath: file.path,
          originalName: 'Service business card.pdf',
          mimeType: 'application/pdf',
          role: AttachmentRole.businessCard,
          contactId: serviceId,
        ),
        PendingAttachment(
          sourcePath: file.path,
          originalName: 'Warranty papers.pdf',
          mimeType: 'application/pdf',
          role: AttachmentRole.warranty,
        ),
      ],
    );
    return (await source.repository.load()).items.single;
  }

  test(
    'contacts, warranty papers and linked business cards survive restart',
    () async {
      final item = await saveContacts();
      expect(item.contacts.map((contact) => contact.toJson()), [
        for (final contact in contacts) contact.toJson(),
      ]);
      expect(item.attachments.first.contactId, serviceId);
      expect(item.attachments.last.role, AttachmentRole.warranty);
      final settings = (await source.repository.load()).settings.copyWith(
        languageCode: 'hi',
        highContrast: true,
        reduceMotion: true,
      );
      await source.repository.saveSettings(settings);
      await source.repository.close();
      final reopened = VaultRepository(
        database: KepliDatabase(NativeDatabase(source.databaseFile)),
        root: source.root,
      );
      try {
        final snapshot = await reopened.load();
        expect(snapshot.items.single.toJson(), item.toJson());
        expect(snapshot.settings.toJson(), settings.toJson());
      } finally {
        await reopened.close();
      }
    },
  );

  test('restore preserves contact links and original card bytes', () async {
    final item = await saveContacts();
    final target = await VaultHarness.create();
    final exporter = BackupService(
      repository: source.repository,
      temporaryDirectory: source.work,
      platform: 'ios',
    );
    final importer = BackupService(
      repository: target.repository,
      temporaryDirectory: target.work,
      platform: 'android',
    );
    try {
      final backup = await exporter.exportBackup();
      final preview = await importer.inspectBackup(backup.path);
      try {
        await importer.restore(preview, RestoreMode.replace);
        final restored = (await target.repository.load()).items.single;
        expect(
          restored.contacts.map((contact) => contact.toJson()),
          item.contacts.map((contact) => contact.toJson()),
        );
        expect(restored.attachments.first.contactId, serviceId);
        expect(restored.attachments.first.id, item.attachments.first.id);
        expect(
          await target.repository
              .attachmentFile(restored.attachments.first)
              .readAsBytes(),
          smallPdf,
        );
      } finally {
        await importer.discardPreview(preview);
      }
    } finally {
      await target.dispose();
    }
  });

  test('removing a contact cannot leave an orphan business card', () async {
    final item = await saveContacts();
    await expectLater(
      source.repository.saveItem(item.copyWith(contacts: [])),
      throwsA(isA<KepliException>()),
    );
    expect(
      (await source.repository.load()).items.single.toJson(),
      item.toJson(),
    );
    await source.repository.saveItem(
      item.copyWith(
        contacts: [contacts.first],
        attachments: item.attachments
            .where((attachment) => attachment.contactId != serviceId)
            .toList(),
      ),
    );
    expect(
      await source.repository.attachmentFile(item.attachments.first).exists(),
      isFalse,
    );
  });

  test(
    'another application instance cannot clean up in-flight files',
    () async {
      final second = VaultRepository(
        database: KepliDatabase(NativeDatabase.memory()),
        root: source.root,
      );
      try {
        await expectLater(second.load(), throwsA(isA<KepliException>()));
        await source.repository.close();
        expect((await second.load()).items, isEmpty);
      } finally {
        await second.close();
      }
    },
  );
}
