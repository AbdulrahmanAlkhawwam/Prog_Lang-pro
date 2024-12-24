import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_pres_state.dart';

class AuthPresCubit extends Cubit<AuthPresState> {
  AuthPresCubit() : super(InitialState());

  String? phoneValidate(value) {
    if (value!.isEmpty) {
      return "phone number must be not empty";
    } else if (value.length != 10 || value.substring(0, 2) != "09") {
      return "phone number format must be 09********";
    }
    return null;
  }

  String? passwordValidate(value) {
    if (value!.isEmpty) {
      return "password must be not empty";
    } else if (value.length > 20 || value.length < 8) {
      return "password must be between 8 and 20";
    }
    return null;
  }

  String? nameValidate(value,String nameType ) {
    if (value!.isEmpty) {
      return '$nameType name must be entered';
    } else if (value.length > 20 || value.length < 2) {
      return "$nameType name must be between 2 and 20 letters";
    }
    return null;
  }
}
