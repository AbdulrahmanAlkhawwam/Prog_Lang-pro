part of 'user_bloc.dart';

sealed class UserEvent {}

class DeleteAccount extends UserEvent {}

class EditAccount extends UserEvent {
  final EditAccountParam data;

  EditAccount({required this.data});
}

class GetAccount extends UserEvent {}
