// Renders real Kepli screens to PNG files in build/screenshots.
// Run: .\tool\dev.ps1 test tool\screenshots\capture_test.dart --update-goldens
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/application/vault_controller.dart';
import 'package:kepli/domain/models.dart';
import 'package:kepli/ui/home_screen.dart';
import 'package:kepli/ui/settings_screen.dart';
import 'package:kepli/ui/warranty_detail.dart';
import 'package:kepli/ui/warranty_editor.dart';

import 'package:path/path.dart' as p;

import '../../test/ui/ui_harness.dart';

const _contactSales = 'aaaaaaaa-1111-4111-8111-111111111111';
const _contactService = 'bbbbbbbb-2222-4222-8222-222222222222';

Future<void> _scale(WidgetTester tester, Size logical) async {
  tester.view.devicePixelRatio = 2;
  tester.view.physicalSize = logical * 2;
  await tester.pumpAndSettle();
}

DateTime _ago(int days) => DateTime.now().subtract(Duration(days: days));

void main() {
  late UiHarness harness;
  late List<WarrantyItem> items;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final loader = FontLoader('NotoSans')
      ..addFont(rootBundle.load('assets/fonts/NotoSans-Regular.ttf'))
      ..addFont(rootBundle.load('assets/fonts/NotoSans-Bold.ttf'));
    await loader.load();
    await (FontLoader('NotoSansArabic')
          ..addFont(rootBundle.load('assets/fonts/NotoSansArabic-Regular.ttf')))
        .load();
    // Headless tests do not bundle Material icons; load them from the SDK.
    final icons = File(
      p.join(
        Platform.environment['KEPLI_FLUTTER_ROOT'] ??
            p.join(
              Platform.environment['LOCALAPPDATA'] ?? '',
              'KepliDev',
              'flutter-3.44.7',
            ),
        'bin',
        'cache',
        'artifacts',
        'material_fonts',
        'materialicons-regular.otf',
      ),
    );
    if (icons.existsSync()) {
      final bytes = icons.readAsBytesSync();
      await (FontLoader(
        'MaterialIcons',
      )..addFont(Future.value(ByteData.sublistView(bytes)))).load();
    }
  });

  setUp(() async {
    harness = await UiHarness.create();
    CalendarDate date(int daysAgo) => CalendarDate.fromDateTime(_ago(daysAgo));
    items = [
      uiItem(
        name: 'Dyson V11 vacuum',
        category: 'Appliances',
        vendor: 'Best Buy',
        purchased: date(700),
        months: 24,
        contacts: const [
          ItemContact(
            id: _contactSales,
            role: ContactRole.sales,
            name: 'Maya Lindgren',
            organization: 'Best Buy, Seattle',
            phone: '+1 206 555 0142',
            email: 'maya@example.test',
          ),
          ItemContact(
            id: _contactService,
            role: ContactRole.service,
            name: 'Dyson support',
            organization: 'Authorized service centre',
            phone: '+1 877 555 0199',
          ),
        ],
      ),
      uiItem(
        name: 'Samsung OLED TV 55"',
        category: 'Electronics',
        vendor: 'Costco',
        purchased: date(340),
        months: 12,
      ),
      uiItem(
        name: 'Makita cordless drill',
        category: 'Tools',
        vendor: 'Home Depot',
        purchased: date(100),
        months: 36,
      ),
      uiItem(
        name: 'Bosch dishwasher',
        category: 'Appliances',
        vendor: 'Local appliance store',
        purchased: date(900),
        months: 24,
      ),
      uiItem(
        name: 'Sony headphones WH-1000XM5',
        category: 'Electronics',
        vendor: 'Amazon',
        purchased: date(200),
        months: 12,
        claimed: true,
      ),
    ];
  });

  tearDown(() async => harness.dispose());

  Future<void> seed(WidgetTester tester) async {
    await tester.runAsync(() async {
      for (final item in items) {
        await harness.repository.saveItem(item);
      }
    });
  }

  testWidgets('phone dashboard', (tester) async {
    await seed(tester);
    await harness.pump(tester, const HomeScreen());
    await _scale(tester, const Size(390, 844));
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../../build/screenshots/1-phone-dashboard.png'),
    );
  });

  testWidgets('phone warranty detail', (tester) async {
    await seed(tester);
    await harness.pump(tester, WarrantyDetailScreen(itemId: items.first.id));
    await _scale(tester, const Size(390, 844));
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../../build/screenshots/2-phone-detail.png'),
    );
  });

  testWidgets('phone editor', (tester) async {
    await seed(tester);
    await harness.pump(tester, WarrantyEditor(item: items.first));
    await _scale(tester, const Size(390, 844));
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../../build/screenshots/3-phone-editor.png'),
    );
  });

  testWidgets('tablet split view', (tester) async {
    await seed(tester);
    await harness.pump(tester, const HomeScreen(), size: const Size(1100, 760));
    harness.container!.read(vaultProvider.notifier).selectItem(items.first.id);
    await _scale(tester, const Size(1100, 760));
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../../build/screenshots/4-tablet-split.png'),
    );
  });

  testWidgets('phone settings', (tester) async {
    await seed(tester);
    await harness.pump(
      tester,
      Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: const SettingsScreen(),
      ),
    );
    await _scale(tester, const Size(390, 844));
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../../build/screenshots/5-phone-settings.png'),
    );
  });

  testWidgets('arabic right-to-left dashboard', (tester) async {
    await seed(tester);
    await harness.pump(tester, const HomeScreen(), locale: 'ar');
    await _scale(tester, const Size(390, 844));
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../../build/screenshots/6-phone-arabic-rtl.png'),
    );
  });
}
