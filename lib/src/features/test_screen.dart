import 'package:flutter/material.dart';

import '../core/components/buttons/App_button.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppButton(
          isLoading: false,
          onPressed: () {},
          text: 'Login',
        ),
      ),
    );
  }
}
