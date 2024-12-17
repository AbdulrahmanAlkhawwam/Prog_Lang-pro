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

class CheckAuth extends AuthEvent {}

class Logout extends AuthEvent {}

class Me extends AuthEvent {}
