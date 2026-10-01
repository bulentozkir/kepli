import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/domain/models.dart';

const itemId = '3f2a1b4c-1111-4444-8888-123456789012';
const contactId = '3f2a1b4c-2222-4444-8888-123456789012';
const attachmentId = '3f2a1b4c-3333-4444-8888-123456789012';

WarrantyItem sampleItem({
  CalendarDate? purchaseDate,
  int months = 12,
  bool claimed = false,
  List<ItemContact> contacts = const [],
  List<WarrantyAttachment> attachments = const [],
}) => WarrantyItem(
  id: itemId,
  name: 'Refrigerator',
  category: 'Appliances',
  purchaseDate: purchaseDate ?? CalendarDate(2026, 1, 31),
  warrantyLengthMonths: months,
  createdAt: DateTime.utc(2026, 1, 31, 8),
  updatedAt: DateTime.utc(2026, 1, 31, 8),
  claimed: claimed,
  contacts: contacts,
  attachments: attachments,
);

void main() {
  group('CalendarDate', () {
    test(
      'clamps month-end instead of overflowing into the following month',
      () {
        expect(
          CalendarDate(2026, 1, 31).addMonths(1),
          CalendarDate(2026, 2, 28),
        );
        expect(
          CalendarDate(2024, 1, 31).addMonths(1),
          CalendarDate(2024, 2, 29),
        );
        expect(
          CalendarDate(2024, 2, 29).addMonths(12),
          CalendarDate(2025, 2, 28),
        );
        expect(
          CalendarDate(2026, 12, 31).addMonths(2),
          CalendarDate(2027, 2, 28),
        );
      },
    );

    test('rejects normalized or timestamp-shaped purchase dates', () {
      for (final value in [
        '2026-02-30',
        '2026-13-01',
        '2026-01-00',
        '2026-01-01T00:00:00Z',
        '01/02/2026',
      ]) {
        expect(() => CalendarDate.parse(value), throwsA(isA<KepliException>()));
      }
    });

    test(
      'counts calendar days independently of daylight-saving transitions',
      () {
        expect(
          CalendarDate(2026, 3, 9).differenceInDays(CalendarDate(2026, 3, 8)),
          1,
        );
        expect(
          CalendarDate(2026, 11, 2).differenceInDays(CalendarDate(2026, 11, 1)),
          1,
        );
      },
    );

    test('calendar backup dates are invariant across timestamp time zones', () {
      final json = sampleItem().toJson();
      json['created_at'] = '2026-01-31T12:00:00+12:00';
      json['updated_at'] = '2026-01-30T16:00:00-08:00';
      final restored = WarrantyItem.fromJson(json);
      expect(restored.purchaseDate.toString(), '2026-01-31');
      expect(restored.expiryDate.toString(), '2027-01-31');
      expect(restored.createdAt, restored.updatedAt);
    });
  });

  test(
    'expiry date remains covered and claimed overrides calculated status',
    () {
      final item = sampleItem(months: 1);
      expect(item.statusAt(CalendarDate(2026, 2, 28)), ItemStatus.active);
      expect(item.statusAt(CalendarDate(2026, 3, 1)), ItemStatus.expired);
      expect(
        item.copyWith(claimed: true).statusAt(CalendarDate(2027, 3, 1)),
        ItemStatus.claimed,
      );
      expect(item.toJson().containsKey('expiry_date'), isFalse);
    },
  );

  test('contacts and their business cards survive model serialization', () {
    const contact = ItemContact(
      id: contactId,
      role: ContactRole.service,
      name: 'Service desk',
      organization: 'Local Repairs',
      phone: '+1 555 0100',
      email: 'service@example.test',
    );
    final card = WarrantyAttachment(
      id: attachmentId,
      relativePath: 'attachments/$itemId/$attachmentId.pdf',
      originalName: 'business-card.pdf',
      mimeType: 'application/pdf',
      role: AttachmentRole.businessCard,
      contactId: contactId,
      size: 10,
      sha256: 'a' * 64,
      addedAt: DateTime.utc(2026, 1, 31),
    );
    final item = sampleItem(contacts: [contact], attachments: [card]);
    final restored = WarrantyItem.fromJson(item.toJson());
    expect(restored.contacts.single.toJson(), contact.toJson());
    expect(restored.attachments.single.contactId, contactId);
    expect(restored.copyWith(claimed: true).contacts.single.id, contactId);
    expect(
      () => restored.copyWith(contacts: []).validate(),
      throwsA(isA<KepliException>()),
    );
  });

  test('English defaults and accessibility preferences survive backups', () {
    expect(AppSettings().languageCode, 'en');
    expect(supportedLanguageCodes.toSet(), hasLength(30));
    final settings = AppSettings(
      languageCode: 'ar',
      highContrast: true,
      reduceMotion: true,
    );
    final restored = AppSettings.fromJson(settings.toJson());
    expect(restored.languageCode, 'ar');
    expect(restored.highContrast, isTrue);
    expect(restored.reduceMotion, isTrue);
    final older = AppSettings().toJson()
      ..remove('language_code')
      ..remove('high_contrast')
      ..remove('reduce_motion');
    expect(AppSettings.fromJson(older).languageCode, 'en');
    expect(
      () => AppSettings(languageCode: 'invalid').validate(),
      throwsA(isA<KepliException>()),
    );
  });

  test('invalid prices, categories and reminder values are rejected', () {
    expect(
      () => AppSettings(categories: ['Tools', 'tools']).validate(),
      throwsA(isA<KepliException>()),
    );
    expect(
      () => AppSettings(reminderDays: [7, 7]).validate(),
      throwsA(isA<KepliException>()),
    );
    final json = sampleItem().toJson()..['price'] = '-12';
    expect(() => WarrantyItem.fromJson(json), throwsA(isA<KepliException>()));
  });

  test('backup timestamps must not normalize invalid calendar fields', () {
    for (final timestamp in [
      '2026-02-30T09:00:00Z',
      '2026-01-31T25:00:00Z',
      '2026-01-31T09:00:00',
      '2026-01-31T09:00:00+25:00',
    ]) {
      final json = sampleItem().toJson()..['updated_at'] = timestamp;
      expect(() => WarrantyItem.fromJson(json), throwsA(isA<KepliException>()));
    }
  });
}
