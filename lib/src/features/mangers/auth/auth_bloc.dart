import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../datasources/auth/auth_remote_datasource.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRemoteDatasource datasource;

  AuthBloc({required this.datasource})
      : super(AuthState(status: AuthStatus.init)) {
    on<Login>(_login);
  }

  FutureOr<void> _login(Login event, Emitter<AuthState> emit) {
    datasource.login(event.phoneNumber, event.password);
  }
}
