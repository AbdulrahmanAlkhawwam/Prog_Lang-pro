import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:program_language_project/src/core/components/buttons/App_button.dart';
import 'package:program_language_project/src/core/components/inters/app_input.dart';
import 'package:program_language_project/src/core/components/widgets/bounded_list_view.dart';
import 'package:program_language_project/src/core/constants/res.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Center(
            child: SvgPicture.asset(Res.register),
          ),
        ),
        Expanded(
          child: Form(
            key: globalKey,
            child: BoundedListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 36, right: 36, bottom: 8),
                  child: AppInput(
                    controller: firstName,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36),
                  child: AppInput(
                    controller: lastName,
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
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                  child: AppInput(
                    controller: phoneNumber,
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
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36),
                  child: AppInput(
                    controller: password,
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
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                  child: AppInput(
                    controller: confirmPassword,
                    isEnabled: true,
                    hint: 'confirm password',
                    onChanged: (value) {
                      if (value == password.text) {
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
                ),
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
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
