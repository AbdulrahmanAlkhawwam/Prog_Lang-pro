import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:program_language_project/src/features/product/domain/entities/product.dart';

import '../../../../../../core/utils/message.dart';
import '../../../../../shop/domain/entities/shop.dart';
import '../../../../domain/repositories/main_repository.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final MainRepository repository;

  MainCubit({required this.repository}) : super(MainState());

  FutureOr<void> searchStore(String searchText) async {
    emit(state.copyWith(status: SearchStatus.loading));
    final response = await repository.searchStore(searchText);
    response.fold(
      (failure) => emit(state.copyWith(
          status: SearchStatus.error,
          message: Message.fromFailure(failure),
          searchStoreResult: [])),
      (result) => emit(state.copyWith(
        status: SearchStatus.founded,
        searchStoreResult: result,
      )),
    );
  }

  FutureOr<void> searchProduct(String searchText) async {
    emit(state.copyWith(status: SearchStatus.loading));
    final response = await repository.searchProduct(searchText);
    response.fold(
      (failure) => emit(state.copyWith(
          status: SearchStatus.error,
          message: Message.fromFailure(failure),
          searchProductResult: [])),
      (result) => emit(state.copyWith(
        status: SearchStatus.founded,
        searchProductResult: result,
      )),
    );
  }

  String image(String path) => repository.image(path);
}
