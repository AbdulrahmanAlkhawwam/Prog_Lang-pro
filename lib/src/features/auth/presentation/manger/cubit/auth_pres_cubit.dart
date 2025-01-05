import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';

import '../../../../../core/localization/keys.g.dart';

part 'auth_pres_state.dart';

class AuthPresCubit extends Cubit<AuthPresState> {
  AuthPresCubit() : super(InitialState());

  String? phoneValidate(value) {
    if (value!.isEmpty) {
      return LocaleKeys.auth_validate_number_empty.tr();
    } else if (value.length != 10 || value.substring(0, 2) != "09") {
      return LocaleKeys.auth_validate_number_format.tr();
    }
    return null;
  }

  String? passwordValidate(value) {
    if (value!.isEmpty) {
      return LocaleKeys.auth_validate_password_empty.tr();
    } else if (value.length > 20 || value.length < 8) {
      return LocaleKeys.auth_validate_password_length.tr();
    }
    return null;
  }

  String? nameValidate(value, int nameType) {
    if (value!.isEmpty) {
      return nameType == 0
          ? LocaleKeys.auth_validate_name_first_name_empty.tr()
          : LocaleKeys.auth_validate_name_last_name_empty.tr();
    } else if (value.length > 20 || value.length < 2) {
      return nameType == 0
          ? LocaleKeys.auth_validate_name_first_name_length.tr()
          : LocaleKeys.auth_validate_name_last_name_length.tr();
    }
    return null;
  }
}
