import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/domain/models.dart';
import 'package:kepli/l10n/app_localizations.dart';
import 'package:kepli/ui/contact_editor.dart';
import 'package:kepli/ui/ui_support.dart';

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  double scale = 1,
  bool rtl = false,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(320, 740);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(() async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
  });
  await tester.pumpWidget(
    MaterialApp(
      locale: Locale(rtl ? 'ar' : 'en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(minimumSize: const Size(48, 48)),
        ),
      ),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: TextScaler.linear(scale)),
        child: Directionality(
          textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        ),
      ),
      home: Scaffold(body: child),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('buttons wrap at 3x text and retain minimum targets', (
    tester,
  ) async {
    await _pump(
      tester,
      PageBody(
        child: Builder(
          builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ActionButton(
                label: context.l10n.scanBusinessCard,
                icon: Icons.document_scanner,
                onPressed: () {},
              ),
              AccessibleIconButton(
                label: context.l10n.close,
                icon: Icons.close,
                onPressed: () {},
              ),
              const StatusBadge(status: ItemStatus.claimed),
            ],
          ),
        ),
      ),
      scale: 3,
      rtl: true,
    );
    expect(tester.takeException(), isNull);
    expect(
      tester.getSize(find.byType(AccessibleIconButton)).height,
      greaterThanOrEqualTo(48),
    );
    expect(
      tester.getSize(find.byType(ActionButton)).height,
      greaterThanOrEqualTo(48),
    );
    final semantics = tester.ensureSemantics();
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    semantics.dispose();
  });

  testWidgets(
    'choice dialog scrolls long labels without constraining text size',
    (tester) async {
      String? selected;
      await _pump(
        tester,
        PageBody(
          child: ChoiceField<String>(
            label: 'Language',
            value: 'en',
            choices: const [
              Choice('en', 'English'),
              Choice('ar', 'العربية'),
              Choice('long', 'A long user-defined category that must wrap'),
            ],
            onChanged: (value) => selected = value,
          ),
        ),
        scale: 3,
        rtl: true,
      );
      await tester.tap(find.byType(ChoiceField<String>));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      final option = find.widgetWithText(
        ActionButton,
        'A long user-defined category that must wrap',
      );
      await tester.ensureVisible(option);
      await tester.pumpAndSettle();
      await tester.tap(option);
      await tester.pumpAndSettle();
      expect(selected, 'long');
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('contact fields validate email and return immutable contact', (
    tester,
  ) async {
    ItemContact? contact;
    await _pump(
      tester,
      Builder(
        builder: (context) => Center(
          child: ActionButton(
            label: context.l10n.addContact,
            icon: Icons.person_add,
            onPressed: () async => contact = await editContact(context),
          ),
        ),
      ),
    );
    await tester.tap(find.byType(ActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('contact-name')),
      'Local service',
    );
    await tester.enterText(
      find.byKey(const Key('contact-email')),
      'bad-address',
    );
    await tester.ensureVisible(find.byKey(const Key('contact-save')));
    await tester.tap(find.byKey(const Key('contact-save')));
    await tester.pumpAndSettle();
    expect(find.text('Enter a valid email address.'), findsOneWidget);
    await tester.enterText(
      find.byKey(const Key('contact-email')),
      'service@example.test',
    );
    await tester.tap(find.byKey(const Key('contact-save')));
    await tester.pumpAndSettle();
    expect(contact?.name, 'Local service');
    expect(contact?.email, 'service@example.test');
    expect(contact?.role, ContactRole.sales);
    expect(isUuid(contact!.id), isTrue);
  });

  testWidgets(
    'errors expose a localized live heading and optional technical details',
    (tester) async {
      await _pump(
        tester,
        const PageBody(child: ErrorPanel(error: 'TEST_EXCEPTION_DETAIL')),
        scale: 3,
        rtl: true,
      );
      final strings = lookupAppLocalizations(const Locale('ar'));
      expect(find.text(strings.operationFailed), findsOneWidget);
      expect(find.text('TEST_EXCEPTION_DETAIL'), findsNothing);
      await tester.tap(find.text(strings.technicalDetails));
      await tester.pumpAndSettle();
      expect(find.text('TEST_EXCEPTION_DETAIL'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
