import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/app_bottom_bar.dart';
import '../../../../core/utils/app_context.dart';
import '../../../auth/presentation/pages/profile_screen.dart';
import '../../../order/presentation/pages/orders_screen.dart';
import '../../../shop/presentation/pages/shops_screen.dart';
import '../manger/cubit/home/home_cubit.dart';
import 'cart_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        return Scaffold(
          body: cubit.getScreen(),
          bottomNavigationBar: AppBottomBar(
            onTap: (index) => setState(() {
              if (index == 4) context.push(ProfileScreen());
              switch (index) {
                case 0:
                  cubit.setScreen(screen: Screens.home);
                case 1:
                  cubit.setScreen(screen: Screens.shops);
                case 2:
                  cubit.setScreen(screen: Screens.orders);
                case 3:
                  cubit.setScreen(screen: Screens.cart);
                default:
                  cubit.setScreen(screen: Screens.user);
              }
            }),
          ),
        );
      },
    );
  }
}
