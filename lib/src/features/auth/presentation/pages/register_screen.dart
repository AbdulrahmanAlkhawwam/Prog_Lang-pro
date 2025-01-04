import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/components/app_button.dart';
import '../../../../core/components/app_input.dart';
import '../../../../core/components/bounded_list_view.dart';
import '../../../../core/constants/res.dart';
import '../../../../core/localization/keys.g.dart';
import '../../../../core/utils/app_context.dart';
import '../../../home/presentation/pages/main_screen.dart';
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
        if (state.status == AuthStatus.notVerified) {
          context.push(OtpScreen());
        }
        if (state.status == AuthStatus.authorized) {
          context.push(MainScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(flex: 4, child: SvgPicture.asset(Res.register)),
              Expanded(
                flex: 5,
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
                          hint: LocaleKeys.auth_register_first_name_field.tr(),
                          validator: (value) => context
                              .read<AuthPresCubit>()
                              .nameValidate(value, 0),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppInput(
                        controller: lNameController,
                        isEnabled: true,
                        hint: LocaleKeys.auth_register_last_name_field.tr(),
                        validator: (value) => context
                            .read<AuthPresCubit>()
                            .nameValidate(value, 1),
                      ),
                      const SizedBox(height: 16),
                      AppInput(
                        controller: phoneController,
                        isEnabled: true,
                        hint: LocaleKeys.auth_register_phone_field.tr(),
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
                        hint: LocaleKeys.auth_register_password_field.tr(),
                        validator: (value) => context
                            .read<AuthPresCubit>()
                            .passwordValidate(value),
                      ),
                      const SizedBox(height: 16),
                      AppInput(
                        controller: confirmPasswordController,
                        isEnabled: passwordController.text != '',
                        hint: LocaleKeys.auth_register_confirm_password_field
                            .tr(),
                        onChanged: (value) => value == passwordController.text
                            ? setState(() => confirm = true)
                            : setState(() => confirm = false),
                      ),
                      const SizedBox(height: 12),
                      const Spacer(),
                      AppButton(
                        isLoading: state.status == AuthStatus.loading,
                        text: LocaleKeys.auth_register_register_button.tr(),
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
                        child:
                            Text(LocaleKeys.auth_register_have_an_account.tr()),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
