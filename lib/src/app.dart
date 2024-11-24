import 'package:flutter/material.dart';

import '../src/core/constants/theme.dart';
import '../src/features/test_screen.dart';

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
