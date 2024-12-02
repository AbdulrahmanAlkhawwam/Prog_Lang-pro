import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:program_language_project/src/features/mangers/test_bloc.dart';

import '../src/core/constants/theme.dart';
import '../src/features/test_screen.dart';
import 'core/service_locator/service_locator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: BlocProvider<TestBloc>(
        create: (_) {
          sl.get<TestBloc>().add(GetProducts());
          return sl.get<TestBloc>();
        },
        child: TestScreen(),
      ),
    );
  }
}
