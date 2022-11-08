import 'package:flutter/material.dart';
import 'package:movie_mania/src/features/home/screens/home_screen.dart';

import 'core/themes/theme_data.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeConfig.themeFromSeed,
      home: const HomeScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('help'),
    );
  }
}
