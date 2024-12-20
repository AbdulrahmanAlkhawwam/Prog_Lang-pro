import 'dart:async';
import 'dart:io';

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
    on<CheckAuth>(_checkAuth);
    on<OTP>(_checkOtp);
    on<Me>(_getMyProfile);
    on<Register>(_register);
    on<Logout>(_logout);
    on<Login>(_login);
    on<UpdateUserImage>(_updateUserImage); 
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
        _saveToken(user.token!);
      },
    );
  }

  FutureOr<void> _getMyProfile(Me event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await repository.me();
    response.fold(
      (failure) => emit(state.copyWith(
          status: AuthStatus.error, message: Message.fromFailure(failure))),
      (user) => emit(state.copyWith(status: AuthStatus.success, user: user)),
    );
  }

  FutureOr<void> _checkAuth(event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await repository.checkToken();
    response.fold(
        (failure) => emit(state.copyWith(
              status: AuthStatus.error,
              message: Message.fromFailure(failure),
            )),
        (haveToken) => emit(
              state.copyWith(
                  status: haveToken
                      ? AuthStatus.authorized
                      : AuthStatus.unauthorized),
            ));
  }

  FutureOr<void> _logout(Logout event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await repository.logout();
    response.fold(
      (failure) => emit(state.copyWith(
          status: AuthStatus.error, message: Message.fromFailure(failure))),
      (_) {
        emit(state.copyWith(status: AuthStatus.unauthorized));
        _deleteToken();
      },
    );
  }

  FutureOr<void> _register(Register event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await repository.register(
      event.firstName,
      event.lastName,
      event.phoneNumber,
      event.password,
    );

    response.fold(
      (failure) => emit(state.copyWith(
          status: AuthStatus.error, message: Message.fromFailure(failure))),
      (user) => emit(state.copyWith(status: AuthStatus.authorized, user: user)),
    );
  }

  FutureOr<void> _checkOtp(OTP event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await repository.otp(event.passkey);
    response.fold(
        (failure) => emit(state.copyWith(
              status: AuthStatus.unauthorized,
              message: Message.fromFailure(failure),
            )),
        (result) => emit(state.copyWith(
            status: result ? AuthStatus.authorized : AuthStatus.unauthorized)));
  }
  FutureOr<void> _updateUserImage(UpdateUserImage event, Emitter<AuthState> emit) async {

    final updatedUser = state.user?.copyWith(imageUrl: event.image); 
    emit(state.copyWith(user: updatedUser)); 
  }


  void _deleteToken() => repository.deleteToken();

  void _saveToken(String token) => repository.saveToken(token);
}

