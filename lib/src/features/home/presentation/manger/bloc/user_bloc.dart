import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../core/utils/message.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/use_cases/delete_account_uc.dart';
import '../../../domain/use_cases/edit_account_uc.dart';
import '../../../domain/use_cases/get_account_uc.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final DeleteAccountUC deleteAccountUC;
  final EditAccountUC editAccountUc;
  final GetAccountUC getAccountUc;

  UserBloc({
    required this.deleteAccountUC,
    required this.editAccountUc,
    required this.getAccountUc,
  }) : super(UserState()) {
    on<DeleteAccount>(_deleteAccount);
    on<GetAccount>(_getAccount);
    on<EditAccount>(_editAccount);
  }

  FutureOr<void> _getAccount(GetAccount event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    final response = await getAccountUc();
    response.fold(
      (failure) => emit(state.copyWith(
          status: UserStatus.error, message: Message.fromFailure(failure))),
      (user) {
        emit(
          state.copyWith(
            status: UserStatus.success,
            user: user,
          ),
        );
      },
    );
  }

  _deleteAccount(DeleteAccount event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    final response = await deleteAccountUC();

    response.fold(
      (failure) => emit(state.copyWith(
          status: UserStatus.error, message: Message.fromFailure(failure))),
      (_) => emit(state.copyWith(status: UserStatus.deleted)),
    );
  }

  FutureOr<void> _editAccount(
      EditAccount event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    final response = await editAccountUc(param: event.data);
    response.fold(
        (failure) => emit(state.copyWith(
              status: UserStatus.error,
              message: Message.fromFailure(failure),
            )),
        (_) => emit(state.copyWith(status: UserStatus.success)));
  }
}
