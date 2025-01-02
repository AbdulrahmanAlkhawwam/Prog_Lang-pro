import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/components/app_button.dart';
import '../../../../core/components/app_input.dart';
import '../../../../core/components/bounded_list_view.dart';
import '../../../../core/components/dialogs/delete_dialog.dart';
import '../../../../core/constants/res.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/app_context.dart';
import '../../../files/presentation/bloc/file_bloc.dart';
import '../../../home/domain/entities/Location.dart';
import '../../../home/presentation/manger/cubit/main_cubit.dart';
import '../../domain/use_cases/edit_account_uc.dart';
import '../manger/bloc/auth_bloc.dart';
import '../manger/cubit/auth_pres_cubit.dart';
import './login_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final TextEditingController fNameController;
  final TextEditingController lNameController;
  final TextEditingController phoneController;
  final Location? location;

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
  late Location? location;

  File? _image;
  final key = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  @override
  void initState() {
    super.initState();
    fNameController = widget.fNameController;
    lNameController = widget.lNameController;
    location = widget.location;
  }

  // String get locationImage {
  //   return 'https://api.tomtom.com/map/1/staticimage?layer=basic&style=main&format=png&zoom=6&center=${location?.longitude}%2C%20${location?.latitude}&width=1024&height=512&view=Unified&key=${Env.map}';
  // }

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
                    context.read<AuthBloc>().add(
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
                                  : Image.network(
                                          cubit.image(state.user!.imagePath!))
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
                            child: InkWell(
                              onTap: () async {
                                // location = await context.push(MapScreen());
                              },
                              onLongPress: () =>
                                  setState(() => location = null),
                              child: Container(
                                height: context.height / 5,
                                color: Colors.blue,
                                child: state.user!.location == null ||
                                        state.user!.location?.latitude == null
                                    ? null
                                    : GestureDetector(
                                        // onTap: () async {
                                        //   if (location?.longitude == null ||
                                        //       location?.latitude == null) {
                                        //     ScaffoldMessenger.of(context)
                                        //         .showSnackBar(SnackBar(
                                        //       duration: const Duration(
                                        //           milliseconds: 1500),
                                        //       backgroundColor: Theme.of(context)
                                        //           .colorScheme
                                        //           .primary,
                                        //       content: const Text(
                                        //           "we can't display this location , check if the location is really "),
                                        //     ));
                                        //   } else {
                                        //     await showSimplePickerLocation(
                                        //       initPosition: GeoPoint(
                                        //         latitude: location!.latitude,
                                        //         longitude: location!.longitude,
                                        //       ),
                                        //       context: context,
                                        //       isDismissible: false,
                                        //       radius: 15,
                                        //       zoomOption:
                                        //           const ZoomOption(initZoom: 8),
                                        //       contentPadding:
                                        //           const EdgeInsets.all(10),
                                        //       textCancelPicker: "back",
                                        //       textConfirmPicker: "Ok",
                                        //     );
                                        //   }
                                        // },

                                        // child: CircleAvatar(
                                        //   radius: 70,
                                        //   backgroundImage:
                                        //       NetworkImage(locationImage),
                                        // ),
                                        ),
                              ),
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
                          onPressed: () async {
                            final result = await showDialog(
                              context: context,
                              builder: (context) => DeleteDialog(),
                            );
                            if (result ?? false) {
                              context.read<AuthBloc>().add(DeleteAccount());
                            }
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  )),
              };
            },
          ),
        ),
      ),
    );
  }
}
