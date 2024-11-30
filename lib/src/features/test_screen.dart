import 'package:flutter/material.dart';

import '../core/components/app_button.dart';
import '../core/components/app_input.dart';
import '../core/utils/app_context.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // SvgPicture.asset(Res.unknownUserLight),
          Divider(),
          AppInput(
            isEnabled: true,
          ),
          Divider(),
          AppButton(
            isLoading: false,
            text: "test",
            onPressed: () {
              context.showErrorSnackBar(massage: null);
            },
          )
        ],
      )),
    );
  }
}
