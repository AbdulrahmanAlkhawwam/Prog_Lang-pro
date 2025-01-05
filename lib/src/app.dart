import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:program_language_project/src/features/home/presentation/manger/cubit/cart/cart_cubit.dart';
import 'package:provider/provider.dart';

import 'core/components/screens/loading_screen.dart';
import 'core/constants/theme.dart';
import 'core/service_locator/service_locator.dart';
import 'features/auth/presentation/manger/bloc/auth_bloc.dart';
import 'features/auth/presentation/manger/cubit/auth_pres_cubit.dart';
import 'features/files/presentation/bloc/file_bloc.dart';
import 'features/home/presentation/manger/bloc/user_bloc.dart';
import 'features/home/presentation/manger/theme_notifier.dart';
import 'features/order/presentation/manger/order_bloc.dart';
import 'features/product/presentation/manger/product_bloc.dart';
import 'features/shop/presentation/manger/shop_bloc.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/home/presentation/pages/main_screen.dart';
import 'features/auth/presentation/pages/otp_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => sl.get<AuthBloc>()..add(CheckAuth()), lazy: false),
        BlocProvider(create: (_) => sl.get<OrderBloc>(), lazy: false),
        BlocProvider(create: (_) => sl.get<UserBloc>(), lazy: false),
        BlocProvider(create: (_) => sl.get<ProductBloc>(), lazy: false),
        BlocProvider(create: (_) => sl.get<ShopBloc>(), lazy: false),
        BlocProvider(create: (_) => sl.get<FileBloc>(), lazy: false),
        BlocProvider(create: (_) => sl.get<CartCubit>(), lazy: false),
        BlocProvider(create: (_) => sl.get<AuthPresCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.authorized) {
                context.read<UserBloc>().add(GetAccount());
                context.read<OrderBloc>().add(GetOrders());
                context.read<ShopBloc>().add(GetShops());
                context.read<ShopBloc>().add(GetShopsCategories());
                context.read<ProductBloc>().add(GetProductsCategories());
                context.read<CartCubit>().getCart();
              }
            },
          ),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => sl<ThemeNotifier>()),
          ],
          builder: (context, child) => MaterialApp(
            theme: AppTheme.lightTheme,
            themeMode: context.watch<ThemeNotifier>().themeMode,
            darkTheme: AppTheme.darkTheme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return switch (state.status) {
                  AuthStatus.checking || AuthStatus.init => LoadingScreen(),
                  AuthStatus.notVerified => OtpScreen(),
                  AuthStatus.authorized => MainScreen(),
                  _ => LoginScreen(),
                };
              },
            ),
          ),
        ),
      ),
    );
  }
}
