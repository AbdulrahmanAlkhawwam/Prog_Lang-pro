import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/components/app_button.dart';
import '../../../../core/components/app_input.dart';
import '../../../../core/components/bounded_list_view.dart';
import '../../../../core/constants/res.dart';
import '../../../../core/utils/app_context.dart';
import '../../domain/use_cases/register_uc.dart';
import '../manger/bloc/auth_bloc.dart';
import '../manger/cubit/auth_pres_cubit.dart';
import 'login_screen.dart';
import 'otp_screen.dart';

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
  bool confirm = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authorized ||
            state.status == AuthStatus.error) {
          context.push(OtpScreen());
        }
      },
      builder: (context, state) {
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
                        validator: (value) => context
                            .read<AuthPresCubit>()
                            .nameValidate(value, "first"),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppInput(
                      controller: lNameController,
                      isEnabled: true,
                      hint: 'Last Name',
                      validator: (value) => context
                          .read<AuthPresCubit>()
                          .nameValidate(value, "last"),
                    ),
                    const SizedBox(height: 16),
                    AppInput(
                      controller: phoneController,
                      isEnabled: true,
                      hint: 'phone number',
                      validator: (value) =>
                          context.read<AuthPresCubit>().phoneValidate(value),
                    ),
                    const SizedBox(height: 16),
                    AppInput(
                      controller: passwordController,
                      onChanged: (value) =>
                          value == confirmPasswordController.text
                              ? setState(() => confirm = true)
                              : setState(() => confirm = false),
                      isEnabled: true,
                      hint: 'password',
                      validator: (value) =>
                          context.read<AuthPresCubit>().passwordValidate(value),
                    ),
                    const SizedBox(height: 16),
                    AppInput(
                      controller: confirmPasswordController,
                      isEnabled: passwordController.text != '',
                      hint: 'confirm password',
                      onChanged: (value) => value == passwordController.text
                          ? setState(() => confirm = true)
                          : setState(() => confirm = false),
                    ),
                    const SizedBox(height: 12),
                    const Spacer(),
                    AppButton(
                      isLoading: state.status == AuthStatus.loading,
                      text: 'register',
                      onPressed: confirm
                          ? () {
                              if (globalKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      Register(
                                        data: RegisterParam(
                                          firstName: fNameController.text,
                                          lastName: lNameController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                        ),
                                      ),
                                    );
                              }
                            }
                          : null,
                    ),
                    TextButton(
                      onPressed: () => context.pushReplacement(LoginScreen()),
                      child: Text("I have already account"),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ));
      },
    );
  }
}
