import 'package:flutter/material.dart';
import 'package:program_language_project/src/features/models/Location.dart';
import 'package:program_language_project/src/features/models/user.dart';
import 'package:program_language_project/src/features/screens/user/User_Profile_Screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../src/core/constants/theme.dart';
import 'core/service_locator/service_locator.dart';
import 'features/mangers/auth/auth_bloc.dart';
import 'features/mangers/product_bloc.dart';

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
            create: (context) => sl.get<AuthBloc>(),
          ),
        ],
        child: UserProfileScreen(
          user: User(
            id: 123456,
            phone: 0953550484,
            firstName: "Abdulrahman",
            lastName: "Alkhawwa",
            token: ";ldkvj23467d242kd1nlj1emwcwej1l2ej",
            location: null/*Location(
              latitudes: 1234567.123456,
              longitudes: 1234567.123456,
            )*/,
            imageUrl: null
          ),
        ),
      ),
    );
  }
}
