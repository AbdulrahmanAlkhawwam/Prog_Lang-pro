import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../core/utils/message.dart';
import '../../../../home/domain/entities/user.dart';
import '../../../domain/use_cases/check_token_uc.dart';
import '../../../domain/use_cases/delete_token_uc.dart';
import '../../../domain/use_cases/login_uc.dart';
import '../../../domain/use_cases/logout_uc.dart';
import '../../../domain/use_cases/otp_uc.dart';
import '../../../domain/use_cases/register_uc.dart';
import '../../../domain/use_cases/save_token_uc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckTokenUC checkTokenUC;
  final DeleteTokenUC deleteTokenUC;
  final LoginUC loginUC;
  final LogoutUC logoutUC;
  final OtpUC otpUC;
  final RegisterUC registerUC;
  final SaveTokenUC saveTokenUC;

  AuthBloc({
    required this.checkTokenUC,
    required this.deleteTokenUC,
    required this.loginUC,
    required this.logoutUC,
    required this.otpUC,
    required this.registerUC,
    required this.saveTokenUC,
  }) : super(AuthState()) {
    on<CheckAuth>(_checkAuth);
    on<Login>(_login);
    on<Logout>(_logout);
    on<OTP>(_checkOtp);
    on<Register>(_register);
  }

  FutureOr<void> _login(Login event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await loginUC(param: event.data);

    response.fold(
      (failure) => emit(
        state.copyWith(
          status: AuthStatus.unauthorized,
          message: Message.fromFailure(failure),
        ),
      ),
      (user) {
        emit(
          state.copyWith(
            status: user.isVerified
                ? AuthStatus.authorized
                : AuthStatus.notVerified,
            user: user,
          ),
        );
        _saveToken(user.token!);
      },
    );
  }

  FutureOr<void> _checkAuth(event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.checking));
    final response = await checkTokenUC();
    response.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.error,
        message: Message.fromFailure(failure),
      )),
      (haveToken) {
        emit(
          state.copyWith(
              status:
                  haveToken ? AuthStatus.authorized : AuthStatus.unauthorized),
        );
      },
    );
  }

  FutureOr<void> _logout(Logout event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await logoutUC();
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
    final response = await registerUC(param: event.data);

    response.fold(
      (failure) => emit(
        state.copyWith(
          status: AuthStatus.error,
          message: Message.fromFailure(failure),
        ),
      ),
      (user) {
        emit(
          state.copyWith(
            status: user.isVerified
                ? AuthStatus.authorized
                : AuthStatus.notVerified,
            user: user,
          ),
        );
        _saveToken(user.token!);
      },
    );
  }

  FutureOr<void> _checkOtp(OTP event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await otpUC(param: event.passkey);
    response.fold(
        (failure) => emit(state.copyWith(
              status: AuthStatus.unauthorized,
              message: Message.fromFailure(failure),
            )),
        (result) => emit(state.copyWith(
            status: result ? AuthStatus.authorized : AuthStatus.unauthorized)));
  }

  void _deleteToken() => deleteTokenUC();

  void _saveToken(String token) => saveTokenUC(param: token);
}
