import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/message.dart';
import '../../../models/user.dart';
import '../../../repositories/auth/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthState()) {
    on<Login>(_login);
    on<CheckAuth>(_checkAuth);
  }

  FutureOr<void> _login(Login event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await repository.login(event.phoneNumber, event.password);
    response.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.unauthorized,
        message: Message.fromFailure(failure),
      )),
      (user) {
        emit(state.copyWith(status: AuthStatus.authorized, user: user));
        _saveToken(user.token);
      },
    );
  }

  FutureOr<void> _checkAuth(event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await repository.checkToken();
    response.fold(
        (failure) => emit(state.copyWith(
              status: AuthStatus.unauthorized,
              message: Message.fromFailure(failure),
            )),
        (haveToken) => emit(
              state.copyWith(
                  status: haveToken
                      ? AuthStatus.authorized
                      : AuthStatus.unauthorized),
            ));
  }

  void _saveToken(String token) => repository.saveToken(token);
}
