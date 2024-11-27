import 'package:flutter/material.dart';
import 'package:program_language_project/src/features/screens/shop/shops_screen.dart';

import '../src/core/constants/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: ShopsScreen(),
    );
  }
}
