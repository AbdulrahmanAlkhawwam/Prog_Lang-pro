import 'package:flutter/material.dart';
import 'package:program_language_project/src/core/components/app_button.dart';
import 'package:program_language_project/src/core/utils/app_context.dart';
import 'package:program_language_project/src/features/screens/auth/login_screen.dart';

import '../../../core/components/app_bottom_bar.dart';
import '../shop/shops_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShopsScreen(),
      bottomNavigationBar: AppBottomBar(
        onTap: (index) {},
      ),
    );
  }
}
