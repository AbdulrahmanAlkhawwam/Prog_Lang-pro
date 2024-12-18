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
  final List<Shop> searchResult;

  const MainState({
    this.status = SearchStatus.init,
    this.message,
    this.searchResult = const [],
  });

  MainState copyWith({
    SearchStatus? status,
    Message? message,
    List<Shop>? searchResult,
  }) {
    return MainState(
      message: message ?? this.message,
      status: status ?? this.status,
      searchResult: searchResult ?? this.searchResult,
    );
  }
}
