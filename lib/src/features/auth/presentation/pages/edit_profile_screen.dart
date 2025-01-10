import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:program_language_project/src/core/utils/app_image.dart';
import 'package:program_language_project/src/features/home/presentation/manger/bloc/user/user_bloc.dart';
import 'package:program_language_project/src/features/home/presentation/pages/map_screen.dart';

import '../../../../core/components/app_button.dart';
import '../../../../core/components/app_input.dart';
import '../../../../core/components/bounded_list_view.dart';
import '../../../../core/components/dialogs/delete_dialog.dart';
import '../../../../core/constants/env.dart';
import '../../../../core/constants/res.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_context.dart';
import '../../../files/presentation/bloc/file_bloc.dart';
import '../../../home/domain/entities/Location.dart';
import '../../../home/domain/use_cases/edit_account_uc.dart';
import '../../../home/presentation/manger/cubit/main/main_cubit.dart';
import '../manger/bloc/auth_bloc.dart';
import '../manger/cubit/auth_pres_cubit.dart';
import './login_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final TextEditingController fNameController;
  final TextEditingController lNameController;
  final TextEditingController phoneController;
  final LocalLocation? location;

  const EditProfileScreen({
    super.key,
    required this.fNameController,
    required this.lNameController,
    required this.phoneController,
    required this.location,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController fNameController;
  late TextEditingController lNameController;
  late LocalLocation? location;

  File? _image;
  final key = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  // Future<void> _getCurrentLocation() async {
  //   Location? location = Location();
  //   bool serviceEnabled;
  //   PermissionStatus permissionGranted;
  //   LocationData locationData;
  //
  //   serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) return;
  //   }
  //
  //   permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //
  //   locationData = await location.getLocation();
  //   setState(() {
  //     this.location = LocalLocation(
  //       latitude: locationData.latitude,
  //       longitude: locationData.longitude,
  //     );
  //   });
  // }

  @override
  void initState() {
    super.initState();
    fNameController = widget.fNameController;
    lNameController = widget.lNameController;
    location = widget.location;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<MainCubit>(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.error) {
                context.showErrorSnackBar(massage: state.message);
              }
              if (state.status == AuthStatus.unauthorized) {
                context.pushReplacement(LoginScreen());
              }
            },
          ),
          BlocListener<FileBloc, FileState>(
            listener: (context, state) {
              if (state.status == FileStatus.error) {
                context.showErrorSnackBar(massage: state.message);
              }
              if (state.status == FileStatus.loaded ||
                  state.status == FileStatus.deleted) {
                context.pop();
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  if (key.currentState?.validate() ?? false) {
                    context.read<UserBloc>().add(
                          EditAccount(
                            data: EditAccountParam(
                              firstName: fNameController.text,
                              lastName: lNameController.text,
                              location: null,
                            ),
                          ),
                        );

                    context.read<FileBloc>().add(
                          _image == null
                              ? DeleteImage()
                              : UploadImage(image: _image!),
                        );
                  }
                },
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
                    child: Form(
                      key: key,
                      child: BoundedListView(
                        padding: EdgeInsets.all(36),
                        children: [
                          InkWell(
                              hoverColor: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              onTap: () => _pickImage(),
                              onLongPress: () => setState(() => _image = null),
                              // todo : don't forget to fix this
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: state.user?.imagePath == null
                                    ? null
                                    // todo : don't forget to change this to app image
                                    : Image.network(
                                            cubit.image(state.user!.imagePath!))
                                        .image,
                                foregroundImage: _image == null
                                    ? null
                                    : Image.file(_image!).image,
                                child: SvgPicture.asset(
                                  Theme.of(context).brightness ==
                                          Brightness.light
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
                                  .nameValidate(value, 0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: AppInput(
                              isEnabled: true,
                              controller: widget.lNameController,
                              validator: (value) => context
                                  .read<AuthPresCubit>()
                                  .nameValidate(value, 1),
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
                                child: state.user?.location == null
                                    ? InkWell(
                                        onLongPress: () => location = null,
                                        // onTap: () async => location =
                                        // await context.push(MapScreen()),
                                        child: Container(
                                          padding: EdgeInsets.all(24),
                                          height: context.height / 5,
                                          color: context
                                              .colors.secondaryContainer
                                              .withOpacity(0.3),
                                          child: Center(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "When click on it will get yor current location ",
                                              style: context
                                                  .textTheme.labelLarge
                                                  ?.copyWith(
                                                color: context.colors.secondary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    // todo : don't forget to fix this
                                    : AppImage(
                                        'https://api.tomtom.com/map/1/staticimage?layer=basic&style=main&format=png&zoom=6&center=${state.user?.location?.longitude}%2C%20${state.user?.location?.latitude}&width=1024&height=512&view=Unified&key=${Env.map}')),
                          ),
                          SizedBox(height: 24),
                          AppButton(
                            isLoading: state.status == AuthStatus.loading,
                            text: 'Delete Account',
                            background: context.colors.errorContainer,
                            textColor: context.colors.onErrorContainer,
                            splash: context.colors.error,
                            onPressed: () async {
                              final result = await showDialog(
                                context: context,
                                builder: (context) => DeleteDialog(),
                              );
                              if (result ?? false) {
                                context.read<UserBloc>().add(DeleteAccount());
                              }
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
              };
            },
          ),
        ),
      ),
    );
  }
}
