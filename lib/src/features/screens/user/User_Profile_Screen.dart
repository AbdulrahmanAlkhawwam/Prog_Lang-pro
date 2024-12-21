import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:program_language_project/src/core/constants/strings.dart';
import 'package:program_language_project/src/features/screens/auth/login_screen.dart';

import '../../../core/components/app_button.dart';
import '../../../core/components/bounded_list_view.dart';
import '../../../core/constants/styles.dart';
import '../../../core/service_locator/service_locator.dart';
import '../../../core/utils/app_context.dart';
import '../../../core/constants/res.dart';
import '../../mangers/auth/bloc/auth_bloc.dart';
import '../../models/user.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

       context.read<AuthBloc>().add(UpdateUserImage(_image!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<AuthBloc>()..add(Me()),
      lazy: false,
      child: BlocListener<AuthBloc, AuthState>(
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
                //onPressed:_pickImage,
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
                    state.user?.imageUrl == null
                        ? SvgPicture.asset(
                            Theme.of(context).brightness == Brightness.light
                                ? Res.unknownUserLight
                                : Res.unknownUserDark,
                          )
                        : Image.network(state.user!.imageUrl!),
                    //: Image.file(_image!),
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
      ),
    );
  }
}
