import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/application/vault_controller.dart';
import 'package:kepli/domain/models.dart';
import 'package:kepli/services/backup_service.dart';
import 'package:kepli/ui/backup_screen.dart';
import 'package:kepli/ui/home_screen.dart';
import 'package:kepli/ui/scan_document_screen.dart';
import 'package:kepli/ui/settings_screen.dart';
import 'package:kepli/ui/ui_support.dart';
import 'package:kepli/ui/warranty_detail.dart';
import 'package:kepli/ui/warranty_editor.dart';

import 'ui_harness.dart';

final _png = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+aC1sAAAAASUVORK5CYII=',
);

void main() {
  late UiHarness harness;
  setUp(() async => harness = await UiHarness.create());
  tearDown(() async => harness.dispose());

  testWidgets('search covers names, vendors and localized categories', (
    tester,
  ) async {
    final expired = uiItem(
      name: 'Old drill',
      category: 'Tools',
      purchased: CalendarDate(2000, 1, 1),
    );
    final active = uiItem(name: 'Refrigerator', vendor: 'North shop');
    await tester.runAsync(() async {
      await harness.repository.saveItem(expired);
      await harness.repository.saveItem(active);
    });
    await harness.pump(tester, const HomeScreen(), size: const Size(1280, 900));
    await tester.enterText(find.byKey(const Key('warranty-search')), 'north');
    await tester.pumpAndSettle();
    expect(find.text('1 warranty'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('warranty-search')), 'tools');
    await tester.pumpAndSettle();
    expect(find.text('1 warranty'), findsOneWidget);
    await tester.enterText(
      find.byKey(const Key('warranty-search')),
      'no match',
    );
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView), const Offset(0, -650));
    await tester.pumpAndSettle();
    expect(find.text('No matching warranties'), findsOneWidget);
    await tapVisible(
      tester,
      find.widgetWithText(ActionButton, 'Clear filters'),
    );
    await tester.pumpAndSettle();
    expect(find.text('2 warranties'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('warranty editor saves immutable fields, decimal and contacts', (
    tester,
  ) async {
    await harness.pump(tester, const HomeScreen());
    await tester.tap(find.byTooltip('Add warranty'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('warranty-name')),
      'Coffee machine',
    );
    await tester.enterText(find.byKey(const Key('warranty-price')), '149.95');
    await tester.enterText(
      find.byKey(const Key('warranty-vendor')),
      'Corner shop',
    );
    await tapVisible(tester, find.byKey(const Key('add-contact')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('contact-name')), 'Ada Sales');
    await tester.enterText(
      find.byKey(const Key('contact-email')),
      'ada@example.test',
    );
    await tapVisible(tester, find.byKey(const Key('contact-save')));
    await tester.pumpAndSettle();
    expect(find.text('Ada Sales'), findsOneWidget);
    await tapVisible(tester, find.byKey(const Key('warranty-save')));
    await settleIo(
      tester,
      () => harness.container!.read(vaultProvider).snapshot.items.isNotEmpty,
    );
    final item = harness.container!.read(vaultProvider).snapshot.items.single;
    expect(item.name, 'Coffee machine');
    expect(item.price, '149.95');
    expect(item.vendor, 'Corner shop');
    expect(item.contacts.single.name, 'Ada Sales');
    expect(item.createdAt.isUtc, isTrue);
    expect(item.updatedAt.isUtc, isTrue);
    expect(find.byType(WarrantyEditor), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'editing retains identity and linked cards, removing contact removes cards',
    (tester) async {
      final item = uiItem();
      await tester.runAsync(() => harness.repository.saveItem(item));
      final source = await tester.runAsync(
        () => harness.source(utf8.encode('%PDF-1.4\n%%EOF\n'), suffix: 'pdf'),
      );
      harness.files.selections = [
        PendingAttachment(
          sourcePath: source!.path,
          originalName: 'Business card.pdf',
          mimeType: 'application/pdf',
        ),
      ];
      await harness.pump(tester, WarrantyEditor(item: item));
      await tapVisible(tester, find.byKey(const Key('add-contact')));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('contact-name')),
        'Service desk',
      );
      await tapVisible(tester, find.byKey(const Key('contact-save')));
      await tester.pumpAndSettle();
      await tapVisible(
        tester,
        find.widgetWithText(ActionButton, 'Add business card'),
      );
      await settleIo(
        tester,
        () => find.text('Business card.pdf').evaluate().isNotEmpty,
      );
      expect(harness.files.requestedRole, AttachmentRole.businessCard);
      expect(harness.files.requestedContactId, isNotNull);
      await tapVisible(
        tester,
        find.widgetWithText(ActionButton, 'Remove contact'),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, 'Remove contact'));
      await tester.pumpAndSettle();
      expect(find.text('Business card.pdf'), findsNothing);
      expect(find.text('Service desk'), findsNothing);
      await tester.enterText(
        find.byKey(const Key('warranty-name')),
        'Updated refrigerator',
      );
      await tapVisible(tester, find.byKey(const Key('warranty-save')));
      await settleIo(
        tester,
        () =>
            harness.container!.read(vaultProvider).snapshot.items.single.name ==
            'Updated refrigerator',
      );
      final saved = harness.container!
          .read(vaultProvider)
          .snapshot
          .items
          .single;
      expect(saved.id, item.id);
      expect(saved.createdAt, item.createdAt);
      expect(saved.contacts, isEmpty);
      expect(saved.attachments, isEmpty);
    },
  );

  testWidgets('claim toggle and delete require explicit confirmation', (
    tester,
  ) async {
    final item = uiItem();
    await tester.runAsync(() => harness.repository.saveItem(item));
    await harness.pump(tester, WarrantyDetailScreen(itemId: item.id));
    await tapVisible(
      tester,
      find.widgetWithText(ActionButton, 'Mark as claimed'),
    );
    await settleIo(
      tester,
      () =>
          harness.container!.read(vaultProvider).snapshot.items.single.claimed,
    );
    expect(
      find.widgetWithText(ActionButton, 'Clear claimed status'),
      findsOneWidget,
    );
    await tapVisible(tester, find.byKey(const Key('delete-warranty')));
    await tester.pumpAndSettle();
    expect(find.text('Delete warranty?'), findsOneWidget);
    expect(harness.container!.read(vaultProvider).snapshot.items, hasLength(1));
    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
    await tester.pumpAndSettle();
    expect(harness.container!.read(vaultProvider).snapshot.items, hasLength(1));
  });

  testWidgets(
    'item CSV exports just this warranty and an on-screen share anchor',
    (tester) async {
      final item = uiItem(name: 'Chosen warranty');
      await tester.runAsync(() async {
        await harness.repository.saveItem(item);
        await harness.repository.saveItem(uiItem(name: 'Another warranty'));
      });
      await harness.pump(
        tester,
        WarrantyDetailScreen(itemId: item.id),
        size: const Size(768, 1024),
      );
      await tapVisible(tester, find.widgetWithText(ActionButton, 'Export CSV'));
      await settleIo(tester, () => harness.files.exported.isNotEmpty);
      final csv = await tester.runAsync(
        () => harness.files.exported.single.readAsString(),
      );
      expect(csv, contains('Chosen warranty'));
      expect(csv, isNot(contains('Another warranty')));
      final origin = harness.files.origins.single!;
      expect(origin.width, greaterThan(0));
      expect(origin.height, greaterThan(0));
      expect(origin.top, greaterThanOrEqualTo(0));
      expect(origin.bottom, lessThanOrEqualTo(1024));
    },
  );

  testWidgets('scanner edits multiple pages and returns contact-linked PDF', (
    tester,
  ) async {
    final source = await tester.runAsync(() => harness.source(_png));
    harness.files.selections = [
      for (var i = 0; i < 2; i++)
        PendingAttachment(
          sourcePath: source!.path,
          originalName: 'page-$i.png',
          mimeType: 'image/png',
        ),
    ];
    PendingAttachment? result;
    const contactId = '11111111-1111-4111-8111-111111111111';
    await harness.pump(
      tester,
      Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () async {
              result = await Navigator.of(context).push<PendingAttachment>(
                MaterialPageRoute(
                  builder: (context) => const ScanDocumentScreen(
                    role: AttachmentRole.businessCard,
                    contactId: contactId,
                  ),
                ),
              );
            },
            child: const Text('Launch scanner'),
          ),
        ),
      ),
      size: const Size(768, 1024),
    );
    await tester.tap(find.text('Launch scanner'));
    await tester.pumpAndSettle();
    expect(find.text('Take photo'), findsNothing);
    expect(
      find.textContaining('Select images saved by your scanner'),
      findsOneWidget,
    );
    await tester.enterText(find.byKey(const Key('scan-name')), 'Service cards');
    await tapVisible(tester, find.byKey(const Key('scan-add-images')));
    await settleIo(tester, () => find.text('Page 1').evaluate().isNotEmpty);
    await tapVisible(tester, find.widgetWithText(ActionButton, 'Rotate page'));
    await tester.pumpAndSettle();
    final top = find.byType(Slider).first;
    await tester.ensureVisible(top);
    tester.widget<Slider>(top).onChanged!(0.12);
    await tester.pumpAndSettle();
    await tapVisible(tester, find.widgetWithText(ActionButton, 'Next page'));
    await tester.pumpAndSettle();
    expect(find.text('Page 2'), findsOneWidget);
    await tapVisible(tester, find.byKey(const Key('scan-save')));
    await settleIo(tester, () => result != null);
    expect(result!.role, AttachmentRole.businessCard);
    expect(result!.contactId, contactId);
    expect(result!.mimeType, 'application/pdf');
    expect(harness.scanner.pages, hasLength(2));
    expect(harness.scanner.pages!.first.quarterTurns, 1);
    expect(harness.scanner.pages!.first.cropTop, 0.12);
    expect(tester.takeException(), isNull);
  });

  testWidgets('scanner rejects PDF input behind localized error heading', (
    tester,
  ) async {
    harness.files.selections = const [
      PendingAttachment(
        sourcePath: 'unused.pdf',
        originalName: 'already.pdf',
        mimeType: 'application/pdf',
      ),
    ];
    await harness.pump(tester, const ScanDocumentScreen());
    await tapVisible(tester, find.byKey(const Key('scan-add-images')));
    await tester.pumpAndSettle();
    expect(find.text('The operation could not be completed.'), findsOneWidget);
    expect(find.text('Technical details'), findsOneWidget);
    expect(harness.scanner.pages, isNull);
  });

  testWidgets('settings persist every preference and native language choice', (
    tester,
  ) async {
    await harness.pump(tester, const Scaffold(body: SettingsScreen()));
    await tapVisible(tester, find.byKey(const Key('settings-high-contrast')));
    await tapVisible(tester, find.byKey(const Key('settings-reduce-motion')));
    await tapVisible(tester, find.byKey(const Key('settings-reminders')));
    await tester.enterText(
      find.byKey(const Key('settings-reminder-days')),
      '60, 14, 0',
    );
    await tester.enterText(
      find.byKey(const Key('settings-reminder-hour')),
      '18',
    );
    await tester.enterText(find.byKey(const Key('settings-currency')), 'eur');
    await tapVisible(tester, find.byKey(const Key('settings-language')));
    await tester.pumpAndSettle();
    await tapVisible(tester, find.widgetWithText(ActionButton, 'Français'));
    await tester.pumpAndSettle();
    await tapVisible(tester, find.byKey(const Key('settings-save')));
    await settleIo(
      tester,
      () =>
          harness.container!
              .read(vaultProvider)
              .snapshot
              .settings
              .languageCode ==
          'fr',
    );
    final settings = harness.container!.read(vaultProvider).snapshot.settings;
    expect(settings.currency, 'EUR');
    expect(settings.reminderDays, [60, 14, 0]);
    expect(settings.reminderHour, 18);
    expect(settings.remindersEnabled, isTrue);
    expect(settings.highContrast, isTrue);
    expect(settings.reduceMotion, isTrue);
    expect(harness.reminders.permissionRequests, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'category in-use guard protects deletion and atomic rename updates items',
    (tester) async {
      final item = uiItem(category: 'Appliances');
      await tester.runAsync(() => harness.repository.saveItem(item));
      await harness.pump(tester, const Scaffold(body: SettingsScreen()));
      final card = find.ancestor(
        of: find.text('Appliances'),
        matching: find.byType(Card),
      );
      await tapVisible(
        tester,
        find.descendant(
          of: card,
          matching: find.widgetWithText(ActionButton, 'Delete category'),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.text(
          'This category is used by a warranty. Change that warranty\'s category first.',
        ),
        findsOneWidget,
      );
      await tester.tap(find.widgetWithText(TextButton, 'Close'));
      await tester.pumpAndSettle();
      await tapVisible(
        tester,
        find.descendant(
          of: card,
          matching: find.widgetWithText(ActionButton, 'Rename category'),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key('category-name')), 'Kitchen');
      await tester.tap(find.widgetWithText(TextButton, 'Save'));
      await settleIo(
        tester,
        () =>
            harness.container!
                .read(vaultProvider)
                .snapshot
                .items
                .single
                .category ==
            'Kitchen',
      );
      expect(
        harness.container!.read(vaultProvider).snapshot.settings.categories,
        contains('Kitchen'),
      );
    },
  );

  testWidgets(
    'backup replace is validated and requires destructive confirmation',
    (tester) async {
      final remote = await tester.runAsync(UiHarness.create);
      addTearDown(() => remote!.dispose());
      await tester.runAsync(() async {
        await harness.repository.saveItem(uiItem(name: 'Keep local'));
        await remote!.repository.saveItem(uiItem(name: 'Incoming'));
        final zip = await BackupService(
          repository: remote.repository,
          temporaryDirectory: remote.work,
          platform: 'ios',
        ).exportBackup();
        harness.files.backupPath = zip.path;
      });
      await harness.pump(tester, const Scaffold(body: BackupScreen()));
      await tapVisible(tester, find.byKey(const Key('choose-backup')));
      await settleIo(
        tester,
        () => find.text('Review backup').evaluate().isNotEmpty,
      );
      await tapVisible(tester, find.byKey(const Key('restore-mode')));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ActionButton, 'Replace all'));
      await tester.pumpAndSettle();
      await tapVisible(tester, find.byKey(const Key('restore-backup')));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Permanently replace all 1 warranties'),
        findsOneWidget,
      );
      expect(
        harness.container!.read(vaultProvider).snapshot.items.single.name,
        'Keep local',
      );
      await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
      await tester.pumpAndSettle();
      await tapVisible(tester, find.byKey(const Key('restore-backup')));
      await tester.pumpAndSettle();
      await tester.tap(
        find.widgetWithText(TextButton, 'Replace all warranties'),
      );
      await settleIo(
        tester,
        () =>
            harness.container!.read(vaultProvider).snapshot.items.single.name ==
            'Incoming',
      );
      expect(find.text('Review backup'), findsNothing);
    },
  );

  testWidgets(
    'keyboard can focus and activate a labeled action without gestures',
    (tester) async {
      await harness.pump(tester, const HomeScreen());
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('nav-warranties')), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
