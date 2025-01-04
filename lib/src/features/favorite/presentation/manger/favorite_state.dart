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

  final List<Product> favorites;

  FavoriteState({
    this.status = FavoriteStatus.init,
    this.message,
    this.favorites = const [],
  });

  FavoriteState copyWith({
    Message? message,
    FavoriteStatus? status,
    List<Product>? favorites,
  }) =>
      FavoriteState(
        status: status ?? this.status,
        message: message ?? this.message,
        favorites: favorites ?? this.favorites,
      );
}
