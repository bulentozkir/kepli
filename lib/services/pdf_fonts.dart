import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pdf;

class ReportFonts {
  const ReportFonts({
    required this.regular,
    required this.bold,
    required this.fallback,
  });

  final pdf.Font regular;
  final pdf.Font bold;
  final List<pdf.Font> fallback;
}

Future<ReportFonts> loadReportFonts(Iterable<String> text) async {
  final combined = text.join('\n');
  final families = <String>[];
  const scripts = {
    'NotoSansArabic': r'[\u0600-\u08ff\ufb50-\ufdff\ufe70-\ufeff]',
    'NotoSansDevanagari': r'[\u0900-\u097f]',
    'NotoSansBengali': r'[\u0980-\u09ff]',
    'NotoSansGurmukhi': r'[\u0a00-\u0a7f]',
    'NotoSansGujarati': r'[\u0a80-\u0aff]',
    'NotoSansTamil': r'[\u0b80-\u0bff]',
    'NotoSansTelugu': r'[\u0c00-\u0c7f]',
    'NotoSansKannada': r'[\u0c80-\u0cff]',
    'NotoSansMalayalam': r'[\u0d00-\u0d7f]',
    'NotoSansThai': r'[\u0e00-\u0e7f]',
    'NotoSansJP': r'[\u3040-\u30ff]',
    'NotoSansKR': r'[\u1100-\u11ff\u3130-\u318f\uac00-\ud7af]',
    'NotoSansSC': r'[\u3400-\u9fff\uf900-\ufaff\uff00-\uffef]',
  };
  for (final entry in scripts.entries) {
    if (RegExp(entry.value).hasMatch(combined)) families.add(entry.key);
  }
  final regular = pdf.Font.ttf(
    await rootBundle.load('assets/fonts/NotoSans-Regular.ttf'),
  );
  final bold = pdf.Font.ttf(
    await rootBundle.load('assets/fonts/NotoSans-Bold.ttf'),
  );
  final fallback = <pdf.Font>[];
  for (final family in families) {
    fallback.add(
      pdf.Font.ttf(await rootBundle.load('assets/fonts/$family-Regular.ttf')),
    );
  }
  return ReportFonts(regular: regular, bold: bold, fallback: fallback);
}
