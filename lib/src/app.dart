import 'package:flutter/material.dart';

import 'core/routes/routes.dart';
import 'core/themes/theme_data.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieMania',
      theme: ThemeConfig.themeFromSeed,
      onGenerateRoute: routes,
    );
  }
}
