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

  AuthBloc({required this.repository})
      : super(AuthState(status: AuthStatus.init)) {
    on<Login>(_login);
  }

  FutureOr<void> _login(Login event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await repository.login(event.phoneNumber, event.password);
    response.fold(
      (failure) => emit(state.copyWith(
          status: AuthStatus.error, message: Message.fromFailure(failure))),
      (user) => emit(state.copyWith(status: AuthStatus.success, user: user)),
    );
  }
}
