import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:program_language_project/src/core/components/buttons/App_button.dart';
import 'package:program_language_project/src/core/components/inters/app_input.dart';
import 'package:program_language_project/src/core/components/widgets/bounded_list_view.dart';
import 'package:program_language_project/src/core/constants/res.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: SvgPicture.asset(Res.login)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: BoundedListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: AppInput(
                      isEnabled: true,
                      hint: 'Phone number',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: AppInput(
                      isEnabled: false,
                      hint: 'Password',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: AppButton(isLoading: false, text: 'Login'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('I have already account'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
