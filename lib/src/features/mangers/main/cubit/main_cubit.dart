import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/message.dart';
import '../../../models/shop.dart';
import '../../../repositories/main/main_repository.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final MainRepository repository;

  MainCubit({required this.repository}) : super(MainState());

  FutureOr<void> search(String searchText) async {
    emit(state.copyWith(status: SearchStatus.loading));
    final response = await repository.search(searchText);
    response.fold(
      (failure) => emit(state.copyWith(
          status: SearchStatus.error,
          message: Message.fromFailure(failure),
          searchResult: [])),
      (result) => emit(state.copyWith(
        status: SearchStatus.founded,
        searchResult: result,
      )),
    );
  }

  String image(String path) => repository.image(path);
}
