part of 'auth_bloc.dart';

enum AuthStatus { init, error, success, loading }

@immutable
class AuthState {
  final AuthStatus status;
  final String? message;

  const AuthState({
    required this.status,
    this.message,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? message,
  }) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
