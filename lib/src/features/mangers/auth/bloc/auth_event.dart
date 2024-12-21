part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class Login extends AuthEvent {
  final String phoneNumber;
  final String password;

  Login({
    required this.phoneNumber,
    required this.password,
  });
}

class Register extends AuthEvent {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String password;

  Register({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.password,
  });
}

class CheckAuth extends AuthEvent {}

class Logout extends AuthEvent {}

class Delete extends AuthEvent {}

class Me extends AuthEvent {}

class OTP extends AuthEvent {
  final String passkey;

  OTP({required this.passkey});
}
