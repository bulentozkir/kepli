import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/app.dart';

double contrast(Color foreground, Color background) {
  final first = foreground.computeLuminance();
  final second = background.computeLuminance();
  return (math.max(first, second) + 0.05) /
      (math.min(first, second) + 0.05);
}

void main() {
  for (final brightness in Brightness.values) {
    for (final highContrast in [false, true]) {
      test('$brightness highContrast=$highContrast meets text contrast', () {
        final theme = buildKepliTheme(brightness, highContrast, true);
        final colors = theme.colorScheme;
        for (final pair in [
          (colors.onSurface, colors.surface),
          (colors.onPrimary, colors.primary),
          (colors.onSecondaryContainer, colors.secondaryContainer),
          (colors.onError, colors.error),
          (colors.onSurfaceVariant, colors.surfaceContainer),
        ]) {
          expect(contrast(pair.$1, pair.$2), greaterThanOrEqualTo(4.5));
        }
        expect(theme.materialTapTargetSize, MaterialTapTargetSize.padded);
        expect(
          theme.filledButtonTheme.style!.minimumSize!.resolve({}),
          const Size(48, 48),
        );
      });
    }
  }
}
