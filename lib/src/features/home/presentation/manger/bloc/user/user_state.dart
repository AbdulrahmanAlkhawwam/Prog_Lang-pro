part of 'user_bloc.dart';

enum UserStatus {
  init,
  loading,
  error,
  success,
  deleted,
}

class UserState {
  final UserStatus status;
  final User? user;
  final Message? message;

  UserState({
    this.status = UserStatus.init,
    this.user,
    this.message,
  });

  UserState copyWith({
    UserStatus? status,
    User? user,
    Message? message,
  }) =>
      UserState(
        status: status ?? this.status,
        user: user ?? this.user,
        message: message ?? this.message,
      );
}
