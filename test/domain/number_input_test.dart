import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/domain/number_input.dart';

void main() {
  test('accepts native-script digits without rounding or locale data loss', () {
    for (final text in [
      '123',
      '١٢٣',
      '۱۲۳',
      '१२३',
      '১২৩',
      '੧੨੩',
      '૧૨૩',
      '௧௨௩',
      '౧౨౩',
      '೧೨೩',
      '൧൨൩',
      '๑๒๓',
      '１２３',
    ]) {
      expect(parseWholeNumber(text), 123, reason: text);
    }
  });

  test('accepts decimal comma and Arabic separator without binary rounding', () {
    expect(canonicalPriceInput('12,34'), '12.34');
    expect(canonicalPriceInput('١٢٫٣٤'), '12.34');
    expect(canonicalPriceInput('0.10'), '0.10');
    expect(canonicalPriceInput('1,234'), isNull);
    expect(canonicalPriceInput('1.234,56'), isNull);
    expect(canonicalPriceInput('-12'), isNull);
  });

  test('parses native reminder numbers and rejects invalid or duplicate values', () {
    expect(parseReminderDays('٣٠، ٧، ١'), [30, 7, 1]);
    expect(parseReminderDays('30, 7, 0'), [30, 7, 0]);
    expect(parseReminderDays(''), isNull);
    expect(parseReminderDays('7, 7'), isNull);
    expect(parseReminderDays('1, -1'), isNull);
    expect(parseReminderDays('1, 3651'), isNull);
  });
}
