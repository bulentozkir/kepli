import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/app.dart';
import 'package:kepli/application/vault_controller.dart';
import 'package:kepli/services/backup_service.dart';
import 'package:kepli/services/reminder_service.dart';
import 'package:kepli/services/report_service.dart';
import 'package:kepli/ui/home_screen.dart';
import 'package:kepli/ui/warranty_detail.dart';

import 'ui_harness.dart';

void main() {
  late UiHarness harness;
  setUp(() async => harness = await UiHarness.create());
  tearDown(() async => harness.dispose());

  testWidgets(
    'real app defaults to English and notification taps open the item',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      tester.binding.platformDispatcher.localesTestValue = const [Locale('tr')];
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.binding.platformDispatcher.clearLocalesTestValue);
      final item = uiItem(name: 'Notification warranty');
      final snapshot = await tester.runAsync(() async {
        await harness.repository.saveItem(item);
        final current = await harness.repository.load();
        await harness.repository.saveSettings(
          current.settings.copyWith(reduceMotion: true),
        );
        return harness.repository.load();
      });
      final reminders = ReminderService();
      addTearDown(() async {
        FocusManager.instance.primaryFocus?.unfocus();
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pumpAndSettle();
        await tester.runAsync(reminders.dispose);
      });
      final dependencies = AppDependencies(
        repository: harness.repository,
        backups: BackupService(
          repository: harness.repository,
          temporaryDirectory: harness.work,
        ),
        reports: ReportService(
          repository: harness.repository,
          temporaryDirectory: harness.work,
        ),
        files: harness.files,
        scanner: harness.scanner,
        reminders: reminders,
        initialSnapshot: snapshot!,
        initialReminderStatus: const ReminderStatus(
          authorized: false,
          supported: false,
        ),
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [dependenciesProvider.overrideWithValue(dependencies)],
          child: const KepliApp(),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        Localizations.localeOf(
          tester.element(find.byType(HomeScreen)),
        ).languageCode,
        'en',
      );
      expect(
        MediaQuery.disableAnimationsOf(tester.element(find.byType(HomeScreen))),
        isTrue,
      );
      reminders.onItemSelected!(item.id);
      await tester.pumpAndSettle();
      expect(find.byType(WarrantyDetailScreen), findsOneWidget);
      expect(find.text('Notification warranty'), findsWidgets);
      expect(tester.takeException(), isNull);
    },
  );
}
