part of 'main_cubit.dart';

enum SearchStatus {
  init,
  loading,
  error,
  founded,
}

@immutable
class MainState {
  final SearchStatus status;
  final Message? message;
  final List<Shop> searchStoreResult;
  final List<Product> searchProductResult;

  const MainState({
    this.status = SearchStatus.init,
    this.message,
    this.searchStoreResult = const [],
    this.searchProductResult = const [],
  });

  MainState copyWith({
    SearchStatus? status,
    Message? message,
    List<Shop>? searchStoreResult,
    List<Product>? searchProductResult,
  }) {
    return MainState(
      message: message ?? this.message,
      status: status ?? this.status,
      searchStoreResult: searchStoreResult ?? this.searchStoreResult,
      searchProductResult: searchProductResult ?? this.searchProductResult,
    );
  }
}
