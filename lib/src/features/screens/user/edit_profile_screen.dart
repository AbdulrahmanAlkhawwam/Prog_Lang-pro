import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:program_language_project/src/core/components/app_input.dart';
import 'package:program_language_project/src/core/utils/app_context.dart';
import 'package:program_language_project/src/features/mangers/auth/cubit/auth_pres_cubit.dart';

import '../../../core/components/app_button.dart';
import '../../../core/components/bounded_list_view.dart';
import '../../../core/constants/res.dart';
import '../../../core/constants/styles.dart';
import '../../mangers/auth/bloc/auth_bloc.dart';
import '../auth/login_screen.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController fNameController;

  final TextEditingController lNameController;

  final TextEditingController phoneController;

  const EditProfileScreen({
    super.key,
    required this.fNameController,
    required this.lNameController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthorized) {
          context.pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.mode_edit_outline_outlined),
            ),
          ],
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return switch (state.status) {
              AuthStatus.error => Center(child: Text(state.message.toString())),
              AuthStatus.loading => Center(child: CircularProgressIndicator()),
              _ => SafeArea(
                    child: BoundedListView(
                  padding: EdgeInsets.all(36),
                  children: [
                    state.user?.imageUrl == null
                        ? SvgPicture.asset(
                            Theme.of(context).brightness == Brightness.light
                                ? Res.unknownUserLight
                                : Res.unknownUserDark,
                          )
                        : Image.network(state.user!.imageUrl!),
                    SizedBox(height: 42),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: AppInput(
                        isEnabled: true,
                        controller: fNameController,
                        validator: (value) => context
                            .read<AuthPresCubit>()
                            .nameValidate(value, "first name"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: AppInput(
                        isEnabled: true,
                        controller: lNameController,
                        validator: (value) => context
                            .read<AuthPresCubit>()
                            .nameValidate(value, "last name"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: AppInput(
                        isEnabled: true,
                        controller: phoneController,
                        validator: (value) =>
                            context.read<AuthPresCubit>().phoneValidate(value),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: context.colors.surfaceContainer,
                        borderRadius: BorderRadius.circular(appBor),
                      ),
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        // TODO : change this container to static map with latitude and longitude
                        child: Container(
                          height: context.height / 5,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    AppButton(
                      isLoading: state.status == AuthStatus.loading,
                      text: 'Delete Account',
                      background: context.colors.errorContainer,
                      textColor: context.colors.onErrorContainer,
                      splash: context.colors.error,
                      onPressed: () => context.read<AuthBloc>().add(Delete()),
                    ),
                    SizedBox(height: 20),
                  ],
                )),
            };
          },
        ),
      ),
    );
  }
}
