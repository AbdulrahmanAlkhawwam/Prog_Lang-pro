import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/components/app_button.dart';
import '../../../../core/components/app_input.dart';
import '../../../../core/components/bounded_list_view.dart';
import '../../../../core/components/dialogs/lang_dialog.dart';
import '../../../../core/constants/res.dart';
import '../../../../core/localization/keys.g.dart';
import '../../../../core/utils/app_context.dart';
import '../../../home/presentation/pages/main_screen.dart';
import '../../domain/use_cases/login_uc.dart';
import '../manger/bloc/auth_bloc.dart';
import '../manger/cubit/auth_pres_cubit.dart';
import './otp_screen.dart';
import './register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

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
        if (state.status == AuthStatus.error) {
          context.showErrorSnackBar(massage: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () async => await showDialog(
                  context: context,
                  builder: (context) => LangDialog(),
                ),
                icon: Icon(
                  Icons.g_translate,
                  color: context.colors.primaryContainer,
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(child: SvgPicture.asset(Res.login)),
              Expanded(
                child: Form(
                  key: globalKey,
                  child: BoundedListView(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    children: [
                      const Spacer(),
                      AppInput(
                        isEnabled: true,
                        hint: LocaleKeys.auth_login_phone_field.tr(),
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        validator: (value) =>
                            context.read<AuthPresCubit>().phoneValidate(value),
                      ),
                      const SizedBox(height: 16),
                      AppInput(
                        isEnabled: true,
                        hint: LocaleKeys.auth_login_password_field.tr(),
                        controller: passwordController,
                        validator: (value) => context
                            .read<AuthPresCubit>()
                            .passwordValidate(value),
                      ),
                      const Spacer(),
                      AppButton(
                        isLoading: state.status == AuthStatus.loading,
                        text: LocaleKeys.auth_login_login_button.tr(),
                        onPressed: () {
                          if (globalKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  Login(
                                    data: LoginParam(
                                      phone: phoneController.text,
                                      password: passwordController.text,
                                    ),
                                  ),
                                );
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      TextButton(
                        child: Text(
                            LocaleKeys.auth_login_not_have_an_account.tr()),
                        onPressed: () =>
                            context.pushReplacement(RegisterScreen()),
                      ),
                      const Spacer()
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
