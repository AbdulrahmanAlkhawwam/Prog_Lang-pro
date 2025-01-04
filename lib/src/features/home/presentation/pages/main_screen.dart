import 'package:flutter/material.dart';

import '../../../../core/components/app_bottom_bar.dart';
import '../../../../core/utils/app_context.dart';
import '../../../auth/presentation/pages/profile_screen.dart';
import '../../../order/presentation/pages/orders_screen.dart';
import '../../../shop/presentation/pages/shops_screen.dart';
import 'cart_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget screen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen,
      bottomNavigationBar: AppBottomBar(
        onTap: (index) => setState(() {
          if (index == 4) {
            context.push(ProfileScreen());
          }
          switch (index) {
            case 0:
              screen = HomeScreen();
            case 1:
              screen = ShopsScreen();
            case 2:
              screen = OrdersScreen();
            case 3:
              screen = CartScreen();
            default:
              screen = screen;
          }
        }),
      ),
    );
  }
}
