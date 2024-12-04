part of 'auth_bloc.dart';

enum AuthStatus { init, error, success, loading }

@immutable
class AuthState {
  final AuthStatus status;
  final User? user;

  final Message? message;

  const AuthState({
    required this.status,
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
