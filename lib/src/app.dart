import 'package:flutter/material.dart';
import 'package:program_language_project/src/core/constants/theme.dart';
import 'package:program_language_project/src/features/test_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: TestScreen(),
    );
  }
}
