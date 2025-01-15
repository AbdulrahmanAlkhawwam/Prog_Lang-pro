part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

class GetFavorites extends FavoriteEvent {}

class GetFavorite extends FavoriteEvent {
  final int id;

  GetFavorite({required this.id});
}

class SetFavorite extends FavoriteEvent {
  final int id;

  SetFavorite({required this.id});
}

class DeleteFavorite extends FavoriteEvent {
  final int id;

  DeleteFavorite({required this.id});
}
