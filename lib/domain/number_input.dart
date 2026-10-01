String normalizeDigits(String value) {
  const zeroes = [
    0x0660,
    0x06f0,
    0x0966,
    0x09e6,
    0x0a66,
    0x0ae6,
    0x0be6,
    0x0c66,
    0x0ce6,
    0x0d66,
    0x0e50,
    0xff10,
  ];
  return String.fromCharCodes(
    value.runes.map((rune) {
      for (final zero in zeroes) {
        if (rune >= zero && rune <= zero + 9) return 0x30 + rune - zero;
      }
      return rune;
    }),
  );
}

int? parseWholeNumber(String text) =>
    int.tryParse(normalizeDigits(text).trim());

String? canonicalPriceInput(String text) {
  final value = normalizeDigits(
    text,
  ).trim().replaceAll(',', '.').replaceAll('\u066b', '.');
  if (!RegExp(r'^\d{1,12}(\.\d{1,2})?$').hasMatch(value)) return null;
  return value;
}

List<int>? parseReminderDays(String text) {
  final parts = normalizeDigits(text).trim().split(RegExp(r'[,;\u060c\s]+'));
  if (parts.isEmpty || parts.length > 12) return null;
  final days = <int>[];
  for (final part in parts) {
    final day = int.tryParse(part);
    if (day == null || day < 0 || day > 3650 || days.contains(day)) return null;
    days.add(day);
  }
  return days;
}
