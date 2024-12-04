import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:program_language_project/src/core/constants/res.dart';
import 'package:program_language_project/src/core/utils/app_context.dart';

import '../core/components/buttons/App_button.dart';
import '../core/components/inters/app_input.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(Res.unknownUserLight),
          Divider(),
          // AppInput(
          //   isEnabled: true,
          // ),
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
