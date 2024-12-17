import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/core/utils/app_context.dart';
import 'package:program_language_project/src/features/screens/user/User_Profile_Screen.dart';

import '../../../core/components/app_bottom_bar.dart';
import '../../../core/service_locator/service_locator.dart';
import '../../mangers/auth/auth_bloc.dart';
import '../shop/shops_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (index) {
        _ => ShopsScreen(),
      },
      bottomNavigationBar: AppBottomBar(
        onTap: (index) {
          if (index == 4) {
            context.push(MaterialPageRoute(
              builder: (context) => UserProfileScreen(),
            ));
          } else {
            setState(() {
              this.index = index;
            });
          }
        },
      ),
    );
  }
}
