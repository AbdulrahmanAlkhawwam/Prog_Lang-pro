import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:program_language_project/src/features/favorite/domain/use_cases/get_favorites_uc.dart';

import '../../../../core/utils/message.dart';
import '../../../product/domain/entities/product.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoritesUC getFavoritesUC;

  FavoriteBloc({required this.getFavoritesUC}) : super(FavoriteState()) {
    on<GetFavorites>(_getFavorites);
  }

  FutureOr<void> _getFavorites(
      GetFavorites event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    final response = await getFavoritesUC();
    response.fold(
      (failure) => emit(state.copyWith(
        status: FavoriteStatus.error,
        message: Message.fromFailure(failure),
      )),
      (favorites) => emit(state.copyWith(
        status: FavoriteStatus.success,
        favorites: favorites,
      )),
    );
  }
}
