import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:program_language_project/src/features/screens/auth/otp_screen.dart';

import 'core/constants/theme.dart';
import 'core/service_locator/service_locator.dart';
import 'features/mangers/auth/bloc/auth_bloc.dart';
import 'features/mangers/auth/cubit/auth_pres_cubit.dart';
import 'features/screens/auth/login_screen.dart';
import 'features/screens/main/main_screen.dart';

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
          create: (_) => sl.get<AuthPresCubit>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {},
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.status == AuthStatus.authorized
                  ? MainScreen()
                  : OtpScreen();
            },
          ),
        ),
      ),
    );
  }
}
