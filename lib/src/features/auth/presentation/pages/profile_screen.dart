import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:program_language_project/main.dart';

import '../../../../core/components/app_button.dart';
import '../../../../core/components/bounded_list_view.dart';
import '../../../../core/components/dialogs/lang_dialog.dart';
import '../../../../core/components/dialogs/theme_dialog.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_context.dart';
import '../../../../core/constants/res.dart';
import '../../../home/presentation/manger/cubit/main_cubit.dart';
import '../manger/bloc/auth_bloc.dart';
import 'edit_profile_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<MainCubit>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.unauthorized) {
            context.pushReplacement(LoginScreen());
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () => showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(context.isLTR ? 200 : 0,
                          0, context.isRTL ? 200 : 0, 0),
                      color: context.colors.surfaceContainer,
                      elevation: appBor,
                      items: [
                        PopupMenuItem(
                          child: TextButton(
                            onPressed: () {
                              context.pop();
                              context.push(
                                EditProfileScreen(
                                  fNameController: TextEditingController(
                                    text: state.user?.firstName,
                                  ),
                                  lNameController: TextEditingController(
                                    text: state.user?.lastName,
                                  ),
                                  phoneController: TextEditingController(
                                    text: state.user?.phone.toString(),
                                  ),
                                  location: state.user?.location,
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  color: context.colors.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Edit account",
                                  style: context.textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          child: TextButton(
                            onPressed: () async {
                              context.pop();
                              await showDialog(
                                context: context,
                                builder: (context) => LangDialog(),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.g_translate,
                                  color: context.colors.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Languages",
                                  style: context.textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          child: TextButton(
                            onPressed: () async {
                              context.pop();
                              await showDialog(
                                  context: context,
                                  builder: (context) => ThemeDialog());
                            },
                            child: Row(
                              children: [
                                Icon(
                                  context.isDark
                                      ? Icons.light_mode_outlined
                                      : Icons.dark_mode_outlined,
                                  color: context.colors.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Themes",
                                  style: context.textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    icon: Icon(Icons.more_vert_outlined),
                  ),
                ],
              ),
              body: switch (state.status) {
                AuthStatus.error =>
                  Center(child: Text(state.message.toString())),
                AuthStatus.loading =>
                  Center(child: CircularProgressIndicator()),
                _ => SafeArea(
                    child: BoundedListView(
                      padding: EdgeInsets.all(36),
                      children: [
                        state.user?.imagePath == null
                            ? SvgPicture.asset(
                                Theme.of(context).brightness == Brightness.light
                                    ? Res.unknownUserLight
                                    : Res.unknownUserDark,
                              )
                            : Image.network(
                                context
                                    .read<MainCubit>()
                                    .image(state.user!.imagePath!),
                                height: 80,
                                width: 80,
                              ),
                        SizedBox(height: 42),
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: context.colors.surfaceContainer,
                            borderRadius: BorderRadius.circular(appBor),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          margin: EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              Icon(Icons.person_outlined),
                              const SizedBox(width: 12),
                              Text(
                                state.user?.firstName ?? "first name",
                                style: context.textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: context.colors.surfaceContainer,
                            borderRadius: BorderRadius.circular(appBor),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          margin: EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              Icon(Icons.person_outlined),
                              const SizedBox(width: 12),
                              Text(
                                state.user?.lastName ?? "last name",
                                style: context.textTheme.bodySmall,
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: context.colors.surfaceContainer,
                            borderRadius: BorderRadius.circular(appBor),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          margin: EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              Icon(Icons.phone_outlined),
                              const SizedBox(width: 12),
                              Text(
                                "0${state.user?.phone}",
                                style: context.textTheme.bodySmall,
                              )
                            ],
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
                          text: 'Logout',
                          background: context.colors.errorContainer,
                          textColor: context.colors.onErrorContainer,
                          splash: context.colors.error,
                          onPressed: () {
                            context.read<AuthBloc>().add(Logout());
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  )
              },
            );
          },
        ),
      ),
    );
  }
}
