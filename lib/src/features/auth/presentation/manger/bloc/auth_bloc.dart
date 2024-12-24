import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/use_cases/check_token_uc.dart';
import '../../../domain/use_cases/delete_account_uc.dart';
import '../../../domain/use_cases/delete_token_uc.dart';
import '../../../domain/use_cases/edit_account_uc.dart';
import '../../../domain/use_cases/get_account_uc.dart';
import '../../../domain/use_cases/login_uc.dart';
import '../../../domain/use_cases/logout_uc.dart';
import '../../../domain/use_cases/otp_uc.dart';
import '../../../domain/use_cases/register_uc.dart';
import '../../../domain/use_cases/save_token_uc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckTokenUC checkTokenUC;
  final DeleteAccountUC deleteAccountUC;
  final DeleteTokenUC deleteTokenUC;
  final EditAccount editAccountUc;
  final GetAccountUC getAccountUc;
  final LoginUC loginUC;
  final LogoutUC logoutUC;
  final OtpUC otpUC;
  final RegisterUC registerUC;
  final SaveTokenUC saveTokenUC;

  AuthBloc({
    required this.checkTokenUC,
    required this.deleteAccountUC,
    required this.deleteTokenUC,
    required this.editAccountUc,
    required this.getAccountUc,
    required this.loginUC,
    required this.logoutUC,
    required this.otpUC,
    required this.registerUC,
    required this.saveTokenUC,
  }) : super(AuthState()) {
    on<DeleteAccount>(_deleteAccount);
    on<CheckAuth>(_checkAuth);
    on<GetAccount>(_getAccount);
    on<Login>(_login);
    on<Logout>(_logout);
    on<OTP>(_checkOtp);
    on<Register>(_register);
    // on<UpdateUserImage>(_updateUserImage);
  }

  FutureOr<void> _getAccount(GetAccount event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await getAccountUc();
    response.fold(
      (failure) => emit(state.copyWith(
          status: AuthStatus.error, message: Message.fromFailure(failure))),
      (user) => emit(state.copyWith(status: AuthStatus.authorized, user: user)),
    );
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
            status: AuthStatus.authorized,
            user: user,
          ),
        );
        _saveToken(user.token!);
      },
    );
  }

  FutureOr<void> _checkAuth(event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await checkTokenUC();
    response.fold(
        (failure) => emit(state.copyWith(
              status: AuthStatus.error,
              message: Message.fromFailure(failure),
            )), (haveToken) {
      emit(
        state.copyWith(
          status: haveToken ? AuthStatus.authorized : AuthStatus.unauthorized,
        ),
      );
      if (haveToken) add(GetAccount());
    });
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
            status: AuthStatus.authorized,
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

  // FutureOr<void> _updateUserImage(
  //     UpdateUserImage event, Emitter<AuthState> emit) async {
  //   final updatedUser = state.user?.copyWith(imagePath: event.image);
  //   emit(state.copyWith(user: updatedUser));
  // }

  void _deleteToken() => deleteTokenUC();

  void _saveToken(String token) => saveTokenUC(param: token);

  FutureOr<void> _deleteAccount(
      DeleteAccount event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final response = await deleteAccountUC();

    response.fold(
      (failure) => emit(state.copyWith(
          status: AuthStatus.error, message: Message.fromFailure(failure))),
      (_) => emit(state.copyWith(status: AuthStatus.unauthorized)),
    );
  }
}
