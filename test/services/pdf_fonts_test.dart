import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/services/pdf_fonts.dart';
import 'package:pdf/widgets.dart' as pdf;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('bundled report fonts cover all thirty language scripts offline', () async {
    const text =
        'English Français Deutsch Español Português Türkçe Tiếng Việt '
        'Русский Українська Polski Kiswahili العربية فارسی اردو '
        'हिन्दी मराठी বাংলা ਪੰਜਾਬੀ ગુજરાતી தமிழ் తెలుగు ಕನ್ನಡ മലയാളം '
        'ไทย 中文 日本語 한국어';
    final fonts = await loadReportFonts([text]);
    final document = pdf.Document();
    var checkedGlyphs = false;
    document.addPage(
      pdf.Page(
        build: (context) {
          final candidates = [
            fonts.regular,
            ...fonts.fallback,
          ].map((font) => font.getFont(context)).toList();
          for (final rune in text.runes) {
            expect(
              candidates.any((font) => font.isRuneSupported(rune)),
              isTrue,
              reason: 'Missing bundled glyph U+${rune.toRadixString(16)}',
            );
          }
          checkedGlyphs = true;
          return pdf.Text(
            text,
            style: pdf.TextStyle(
              font: fonts.regular,
              fontFallback: fonts.fallback,
            ),
          );
        },
      ),
    );
    final bytes = await document.save();
    expect(checkedGlyphs, isTrue);
    expect(bytes.length, greaterThan(5000));
    expect(bytes.take(5).toList(), [37, 80, 68, 70, 45]);
  });
}
