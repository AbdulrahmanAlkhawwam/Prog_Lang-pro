part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class DeleteAccount extends AuthEvent {}

class EditAccount extends AuthEvent {
  final EditAccountParam data;

  EditAccount({required this.data});
}

class GetAccount extends AuthEvent {}

class Login extends AuthEvent {
  final LoginParam data;

  Login({required this.data});
}

class Logout extends AuthEvent {}

class CheckAuth extends AuthEvent {}

class Register extends AuthEvent {
  final RegisterParam data;

  Register({required this.data});
}

class OTP extends AuthEvent {
  final String passkey;

  OTP({required this.passkey});
}

class UpdateUserImage extends AuthEvent {
  final File image;

  UpdateUserImage(this.image);
}
