import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import 'package:program_language_project/src/core/components/buttons/App_button.dart';
import 'package:program_language_project/src/core/components/inters/app_input.dart';
import 'package:program_language_project/src/core/constants/res.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BoundedListView(
        children: [
          Expanded(child: SvgPicture.asset(Res.login)),
          Expanded(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: AppInput(
                  isEnabled: true,
                  hint: 'Phone number',
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: AppInput(
                  isEnabled: false,
                  hint: 'password',
                ),
              ),
              SizedBox(height: 106),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 65),
                child: AppButton(isLoading: false, text: 'Login'),
              ),
              SizedBox(
                height: 16,
              ),
              TextButton(
                  onPressed: () {}, child: Text('I have already account')),
            ],
          ))
        ],
      ),
    );
  }
}
