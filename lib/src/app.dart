import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/theme.dart';
import 'core/service_locator/service_locator.dart';
import 'features/mangers/auth/cubit/auth_pres_cubit.dart';
import 'features/screens/main/main_screen.dart';
import 'features/mangers/auth/bloc/auth_bloc.dart';
import 'features/mangers/products/product_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>(
            create: (_) => sl.get<ProductBloc>()..add(GetProducts()),
          ),
          BlocProvider(
            create: (_) => sl.get<AuthBloc>(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => sl.get<AuthPresCubit>(),
          ),
        ],
        child: Builder(
          builder: (context) {
            return MainScreen();
          },
        ),
      ),
    );
  }
}
