import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/components/app_button.dart';
import '../../../../core/components/app_input.dart';
import '../../../../core/components/bounded_list_view.dart';
import '../../../../core/constants/res.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_context.dart';
import '../../../home/presentation/manger/cubit/main_cubit.dart';
import '../manger/bloc/auth_bloc.dart';
import '../manger/cubit/auth_pres_cubit.dart';
import './login_screen.dart';

class EditProfileScreen extends StatefulWidget {
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
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
      context.read<AuthBloc>().add(UpdateUserImage(_image!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<MainCubit>(),
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
                onPressed: () {},
                icon: Icon(Icons.done),
              ),
            ],
          ),
          body: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final cubit = context.read<MainCubit>();
              return switch (state.status) {
                AuthStatus.error =>
                  Center(child: Text(state.message.toString())),
                AuthStatus.loading =>
                  Center(child: CircularProgressIndicator()),
                _ => SafeArea(
                      child: BoundedListView(
                    padding: EdgeInsets.all(36),
                    children: [
                      InkWell(
                          onTap: () => _pickImage(),
                          onLongPress: () => print("deleteImage"),
                          child: CircleAvatar(
                            radius: 120,
                            backgroundImage: Image.network(
                                    cubit.image(state.user?.imagePath ?? ''))
                                .image,
                            foregroundImage: _image == null
                                ? null
                                : Image.file(_image!).image,
                            child: SvgPicture.asset(
                              Theme.of(context).brightness == Brightness.light
                                  ? Res.unknownUserLight
                                  : Res.unknownUserDark,
                            ),
                          )),
                      SizedBox(height: 42),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: AppInput(
                          isEnabled: true,
                          controller: widget.fNameController,
                          validator: (value) => context
                              .read<AuthPresCubit>()
                              .nameValidate(value, "first name"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: AppInput(
                          isEnabled: true,
                          controller: widget.lNameController,
                          validator: (value) => context
                              .read<AuthPresCubit>()
                              .nameValidate(value, "last name"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: AppInput(
                          isEnabled: false,
                          controller: widget.phoneController,
                          validator: (value) => context
                              .read<AuthPresCubit>()
                              .phoneValidate(value),
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
                        onPressed: () =>
                            context.read<AuthBloc>().add(DeleteAccount()),
                      ),
                      SizedBox(height: 20),
                    ],
                  )),
              };
            },
          ),
        ),
      ),
    );
  }
}
