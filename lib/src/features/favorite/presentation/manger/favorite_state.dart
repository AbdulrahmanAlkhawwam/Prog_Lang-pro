part of 'favorite_bloc.dart';

enum FavoriteStatus {
  init,
  loading,
  error,
  success,
}

class FavoriteState {
  final Message? message;
  final FavoriteStatus status;
  final bool? isFavorite;

  final List<Product> favorites;

  FavoriteState({
    this.status = FavoriteStatus.init,
    this.message,
    this.isFavorite,
    this.favorites = const [],
  });

  FavoriteState copyWith({
    Message? message,
    FavoriteStatus? status,
    bool? isFavorite,
    List<Product>? favorites,
  }) =>
      FavoriteState(
        status: status ?? this.status,
        message: message ?? this.message,
        isFavorite: isFavorite ?? this.isFavorite,
        favorites: favorites ?? this.favorites,
      );
}
