part of 'auth_bloc.dart';

enum AuthStatus {
  init,
  loading,
  authorized,
  unauthorized,
}

@immutable
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
  }) {
    return AuthState(
      message: message ?? this.message,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
