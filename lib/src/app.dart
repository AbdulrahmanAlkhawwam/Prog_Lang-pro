import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'core/components/loading_screen.dart';
import 'core/constants/theme.dart';
import 'core/service_locator/service_locator.dart';
import 'features/auth/presentation/manger/bloc/auth_bloc.dart';
import 'features/auth/presentation/manger/cubit/auth_pres_cubit.dart';
import 'features/shop/presentation/manger/shop_bloc.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/home/presentation/pages/main_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl.get<AuthBloc>()..add(CheckAuth()),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => sl.get<ShopBloc>(),
          lazy: false,
        ),
        BlocProvider(create: (_) => sl.get<AuthPresCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.authorized) {
                context.read<ShopBloc>().add(GetShops());
              }
            },
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          themeMode: ThemeMode.system,
          darkTheme: AppTheme.darkTheme,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) => switch (state.status) {
              AuthStatus.unauthorized || AuthStatus.error => LoginScreen(),
              AuthStatus.loading || AuthStatus.init => LoadingScreen(),
              AuthStatus.authorized => MainScreen(),
            },
          ),
        ),
      ),
    );
  }
}
