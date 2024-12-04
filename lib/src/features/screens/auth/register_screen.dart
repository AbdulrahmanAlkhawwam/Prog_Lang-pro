import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/components/app_button.dart';
import '../../../core/components/app_input.dart';
import '../../../core/components/bounded_list_view.dart';
import '../../../core/constants/res.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(flex: 2, child: SvgPicture.asset(Res.register)),
        Expanded(
          flex: 3,
          child: Form(
            key: globalKey,
            child: BoundedListView(
              padding: EdgeInsets.symmetric(horizontal: 36),
              children: [
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: AppInput(
                    controller: fNameController,
                    isEnabled: true,
                    hint: 'First Name',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'first name must be entered';
                      } else if (value.length > 20 || value.length < 2) {
                        return "first name must be between 2 and 20 letters";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
                AppInput(
                  controller: lNameController,
                  isEnabled: true,
                  hint: 'Last Name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'last name must be entered';
                    } else if (value.length > 20 || value.length < 2) {
                      return "last name must be between 2 and 20 letters";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16),
                AppInput(
                  controller: phoneController,
                  isEnabled: true,
                  hint: 'phone number',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'phone number must be entered';
                    } else if (value.substring(0, 2) != "09" ||
                        value.length != 10) {
                      return 'phone number must be 09********';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16),
                AppInput(
                  controller: passwordController,
                  isEnabled: true,
                  hint: 'password',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password must be entered';
                    } else if (value.length > 20 || value.length < 8) {
                      return "password must be between 8 and 20 letters";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16),
                AppInput(
                  controller: confirmPasswordController,
                  isEnabled: true,
                  hint: 'confirm password',
                  onChanged: (value) {
                    if (value == passwordController.text) {
                      // TODO : fix border to be green or red color
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "confirm password can't be empty";
                    } else {
                      return null;
                    }
                  },
                ),
                const Spacer(),
                AppButton(
                  isLoading: false,
                  text: 'register',
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {}
                  },
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("I have already account"),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
