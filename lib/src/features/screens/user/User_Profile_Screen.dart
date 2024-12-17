import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/components/app_button.dart';
import '../../../core/components/bounded_list_view.dart';
import '../../../core/constants/styles.dart';
import '../../../core/service_locator/service_locator.dart';
import '../../../core/utils/app_context.dart';
import '../../../core/constants/res.dart';
import '../../mangers/auth/auth_bloc.dart';
import '../../models/user.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<AuthBloc>()..add(Me()),
      lazy: false,
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
          builder: (context, state) => switch (state.status) {
            AuthStatus.error => Center(child: Text(state.message.toString())),
            AuthStatus.loading => Center(child: CircularProgressIndicator()),
            _ => SafeArea(
                  child: BoundedListView(
                padding: EdgeInsets.all(36),
                children: [
                  SvgPicture.asset(
                    Theme.of(context).brightness == Brightness.light
                        ? Res.unknownUserLight
                        : Res.unknownUserDark,
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
                    isLoading: false,
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
              )),
          },
        ),
      ),
    );
  }
}
