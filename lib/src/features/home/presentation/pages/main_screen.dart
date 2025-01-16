import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/app_bottom_bar.dart';
import '../../../../core/utils/app_context.dart';
import '../../../auth/presentation/pages/profile_screen.dart';
import '../../../order/presentation/pages/orders_screen.dart';
import '../../../shop/presentation/pages/shops_screen.dart';

// import '../manger/cubit/home/home_cubit.dart';
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
    // return BlocBuilder<HomeCubit, HomeState>(
    //   builder: (context, state) {
    //     var cubit = context.read<HomeCubit>();
    return Scaffold(
      body: screen,
      // body: cubit.getScreen(),
      bottomNavigationBar: AppBottomBar(
        onTap: (index) => setState(() {
          if (index == 4) context.push(ProfileScreen());
          switch (index) {
            case 0:
              screen = HomeScreen();
            // cubit.setScreen(screen: Screens.home);
            case 1:
              screen = ShopsScreen();
            // cubit.setScreen(screen: Screens.shops);
            case 2:
              screen = OrdersScreen();
            // cubit.setScreen(screen: Screens.orders);
            case 3:
              screen = CartScreen();
            // cubit.setScreen(screen: Screens.cart);
            default:
              // context.push(ProfileScreen());
            // cubit.setScreen(screen: Screens.user);
          }
        }),
      ),
    );
    // }

    // ,
// );
  }
}
