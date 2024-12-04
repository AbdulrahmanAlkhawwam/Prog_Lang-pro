import 'package:flutter/material.dart';

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
