import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/components/app_button.dart';
import '../../../core/components/app_input.dart';
import '../../../core/components/bounded_list_view.dart';
import '../../../core/constants/res.dart';
import '../../../core/utils/app_context.dart';
import '../../mangers/auth/bloc/auth_bloc.dart';
import '../../mangers/auth/cubit/auth_pres_cubit.dart';

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
        if (state.status == AuthStatus.success) {
          context.showSuccessSnackBar();
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
                child: BoundedListView(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  children: [
                    const Spacer(),
                    AppInput(
                      isEnabled: true,
                      hint: 'Phone number',
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      validator: (value) =>
                          context.read<AuthPresCubit>().phoneValidate(value),
                    ),
                    const SizedBox(height: 16),
                    AppInput(
                      isEnabled: true,
                      hint: 'password',
                      controller: passwordController,
                      validator: (value) =>
                          context.read<AuthPresCubit>().passwordValidate(value),
                    ),
                    const Spacer(),
                    AppButton(
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
                    SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("I don't have already account"),
                    ),
                    const Spacer()
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
