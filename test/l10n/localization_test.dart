import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/domain/models.dart';
import 'package:kepli/l10n/app_localizations.dart';
import 'package:kepli/l10n/language_catalog.dart';
import 'package:path/path.dart' as p;

Map<String, dynamic> messages(String language) =>
    jsonDecode(
          File(p.join('lib', 'l10n', 'app_$language.arb')).readAsStringSync(),
        )
        as Map<String, dynamic>;

Set<String> placeholders(String message) => RegExp(
  r'\{(\w+)(?:[,}])',
).allMatches(message).map((match) => match.group(1)!).toSet();

void main() {
  test('every supported language has a full nonempty translated catalog', () {
    final english = messages('en');
    final keys = english.keys.where((key) => !key.startsWith('@')).toSet();
    expect(supportedLanguageCodes.toSet(), hasLength(30));
    expect(languageNames.keys.toSet(), supportedLanguageCodes.toSet());
    expect(
      AppLocalizations.supportedLocales
          .map((locale) => locale.languageCode)
          .toSet(),
      supportedLanguageCodes.toSet(),
    );
    for (final language in supportedLanguageCodes) {
      final translated = messages(language);
      expect(translated['@@locale'], language);
      expect(
        translated.keys.where((key) => !key.startsWith('@')).toSet(),
        keys,
        reason: 'Missing or extra messages for $language',
      );
      var changed = 0;
      for (final key in keys) {
        final value = translated[key];
        expect(value, isA<String>(), reason: '$language/$key');
        expect((value as String).trim(), isNotEmpty, reason: '$language/$key');
        expect(
          placeholders(value),
          placeholders(english[key] as String),
          reason: '$language/$key has different placeholders',
        );
        if (value != english[key]) changed++;
      }
      if (language != 'en') {
        expect(
          changed / keys.length,
          greaterThan(0.80),
          reason: '$language must not be an English placeholder catalog',
        );
      }
      final strings = lookupAppLocalizations(Locale(language));
      expect(strings.appTitle, 'Kepli');
      expect(strings.daysLeft(7), isNot(contains('{count')));
      expect(strings.backupSummary(3, 5), isNot(contains('{items')));
      expect(
        strings.notificationBody('Sample', '2026-10-01'),
        contains('Sample'),
      );
    }
  });

  for (final code in ['ar', 'fa', 'ur']) {
    testWidgets('$code uses right-to-left widget direction', (tester) async {
      TextDirection? direction;
      await tester.pumpWidget(
        MaterialApp(
          locale: Locale(code),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Builder(
            builder: (context) {
              direction = Directionality.of(context);
              return const SizedBox();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(direction, TextDirection.rtl);
    });
  }
}
