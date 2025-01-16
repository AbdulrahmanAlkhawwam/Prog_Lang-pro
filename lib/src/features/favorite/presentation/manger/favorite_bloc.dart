import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:program_language_project/src/features/favorite/domain/use_cases/delete_favorite_uc.dart';
import 'package:program_language_project/src/features/favorite/domain/use_cases/get_favorite_uc.dart';
import 'package:program_language_project/src/features/favorite/domain/use_cases/get_favorites_uc.dart';

import '../../../../core/utils/message.dart';
import '../../../product/domain/entities/product.dart';
import '../../domain/use_cases/set_favorite_uc.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoritesUC getFavoritesUC;
  final GetFavoriteUC getFavoriteUC;
  final SetFavoriteUC setFavoriteUC;
  final DeleteFavoriteUC deleteFavoriteUC;

  FavoriteBloc({
    required this.getFavoritesUC,
    required this.getFavoriteUC,
    required this.setFavoriteUC,
    required this.deleteFavoriteUC,
  }) : super(FavoriteState()) {
    on<GetFavorites>(_getFavorites);
    on<GetFavorite>(_getFavorite);
    on<SetFavorite>(_setFavorite);
    on<DeleteFavorite>(_deleteFavorite);
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

  FutureOr<void> _getFavorite(
      GetFavorite event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    final response = await getFavoriteUC(param: event.id);

    response.fold(
        (failure) => emit(state.copyWith(
              status: FavoriteStatus.error,
              message: Message.fromFailure(failure),
            )),
        (isFavorite) => emit(
              state.copyWith(
                status: FavoriteStatus.success,
                isFavorite: isFavorite,
              ),
            ));
  }

  FutureOr<void> _setFavorite(
      SetFavorite event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    final response = await setFavoriteUC(param: event.id);
    response.fold(
        (failure) => emit(state.copyWith(
              status: FavoriteStatus.error,
              message: Message.fromFailure(failure),
            )),
        (_) => add(GetFavorite(id: event.id)));
  }

  FutureOr<void> _deleteFavorite(
      DeleteFavorite event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    final response = await deleteFavoriteUC(param: event.id);
    response.fold(
        (failure) => emit(state.copyWith(
              status: FavoriteStatus.error,
              message: Message.fromFailure(failure),
            )), (_) {
      add(GetFavorites());
      add(GetFavorite(id: event.id));
    });
  }
}
