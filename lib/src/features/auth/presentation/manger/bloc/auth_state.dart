part of 'auth_bloc.dart';

enum AuthStatus {
  init,
  loading,
  checking,
  error,
  notVerified,
  authorized,
  unauthorized,
}

class AuthState {
  final AuthStatus status;
  final User? user;
  final Message? message;

  const AuthState({
    this.status = AuthStatus.init,
    this.user,
    this.message,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    Message? message,
  }) =>
      AuthState(
        message: message ?? this.message,
        status: status ?? this.status,
        user: user ?? this.user,
      );
}
