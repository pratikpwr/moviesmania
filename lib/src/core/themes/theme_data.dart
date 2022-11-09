import 'package:flutter/material.dart';

import 'text_theme.dart';

class ThemeConfig {
  static ColorScheme colorSchemeFromSeed = ColorScheme.fromSeed(
    seedColor: Colors.pink,
    brightness: Brightness.dark,
  );

  static ThemeData get themeFromSeed => ThemeData.from(
        useMaterial3: true,
        colorScheme: colorSchemeFromSeed,
        textTheme: textTheme(),
      );
}
