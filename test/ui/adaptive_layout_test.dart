import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/l10n/app_localizations.dart';
import 'package:kepli/ui/backup_screen.dart';
import 'package:kepli/ui/home_screen.dart';
import 'package:kepli/ui/scan_document_screen.dart';
import 'package:kepli/ui/settings_screen.dart';
import 'package:kepli/ui/ui_support.dart';
import 'package:kepli/ui/warranty_editor.dart';

import 'ui_harness.dart';

void main() {
  late UiHarness harness;
  setUp(() async => harness = await UiHarness.create());
  tearDown(() async => harness.dispose());

  for (final size in [
    const Size(320, 640),
    const Size(390, 844),
    const Size(768, 1024),
    const Size(1280, 800),
  ]) {
    testWidgets('dashboard adapts without overflow at $size', (tester) async {
      await harness.pump(tester, const HomeScreen(), size: size);
      expect(tester.takeException(), isNull);
      expect(find.text('Kepli'), findsOneWidget);
      expect(find.byTooltip('Add warranty'), findsOneWidget);
      expect(
        find.byType(NavigationRail),
        size.width >= 760 ? findsOneWidget : findsNothing,
      );
      await tester.drag(find.byType(ListView), const Offset(0, -500));
      await tester.pumpAndSettle();
      expect(find.text('No warranties yet'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  for (final entry in <String, Widget>{
    'dashboard': const HomeScreen(),
    'settings': const Scaffold(body: SettingsScreen()),
    'backups': const Scaffold(body: BackupScreen()),
    'editor': const WarrantyEditor(),
    'scanner': const ScanDocumentScreen(),
  }.entries) {
    testWidgets('${entry.key} supports 320px, RTL and 3x text', (tester) async {
      await harness.pump(
        tester,
        entry.value,
        size: const Size(320, 740),
        textScale: 3,
        rtl: true,
        locale: 'ar',
      );
      expect(tester.takeException(), isNull);
      final scroll = find.byType(Scrollable).first;
      for (var i = 0; i < 12; i++) {
        await tester.drag(scroll, const Offset(0, -550));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
      expect(
        Directionality.of(
          tester.element(
            find.byType(PageBody).evaluate().isNotEmpty
                ? find.byType(PageBody).first
                : find.byType(ListView).first,
          ),
        ),
        TextDirection.rtl,
      );
    });
  }

  testWidgets('main actions have accessible labels and 48px targets', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await harness.pump(tester, const HomeScreen());
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    for (final button in tester.widgetList<AccessibleIconButton>(
      find.byType(AccessibleIconButton),
    )) {
      expect(button.label, isNotEmpty);
      final target = find.byWidget(button);
      expect(tester.getSize(target).width, greaterThanOrEqualTo(48));
      expect(tester.getSize(target).height, greaterThanOrEqualTo(48));
    }
    await tester.tap(find.byTooltip('Menu'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('nav-settings')), findsOneWidget);
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    semantics.dispose();
  });

  testWidgets('RTL navigation drawer remains usable at 3x text', (
    tester,
  ) async {
    await harness.pump(
      tester,
      const HomeScreen(),
      size: const Size(320, 740),
      textScale: 3,
      locale: 'ar',
      rtl: true,
    );
    final strings = lookupAppLocalizations(const Locale('ar'));
    await tester.tap(find.byTooltip(strings.menu));
    await tester.pumpAndSettle();
    await tapVisible(tester, find.byKey(const ValueKey('nav-settings')));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
