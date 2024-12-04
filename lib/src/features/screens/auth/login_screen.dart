import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:program_language_project/src/core/utils/app_context.dart';

import '../../../core/components/app_button.dart';
import '../../../core/components/app_input.dart';
import '../../../core/constants/res.dart';
import '../../mangers/auth/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
          context.showErrorSnackBar(massage: state.message.toString());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(child: SvgPicture.asset(Res.login)),
              Expanded(
                  child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: AppInput(
                        isEnabled: true,
                        hint: 'Phone number',
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "phone number must be not empty";
                          } else if (value.length != 10 ||
                              value.substring(0, 2) != "09") {
                            return "phone number format must be 09********";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: AppInput(
                        isEnabled: true,
                        hint: 'password',
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password must be not empty";
                          } else if (value.length > 20 || value.length < 8) {
                            return "password must be between 8 and 20";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 65),
                      child: AppButton(
                        isLoading: state.status == AuthStatus.loading,
                        text: 'Login',
                        onPressed: () {
                          if (globalKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  Login(
                                    phoneNumber: phoneController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("I don't have already account"),
                    ),
                    const Spacer(
                      flex: 1,
                    )
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
