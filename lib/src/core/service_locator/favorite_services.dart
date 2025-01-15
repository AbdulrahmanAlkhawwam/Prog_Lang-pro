import 'package:get_it/get_it.dart';
import 'package:program_language_project/src/features/favorite/data/data_source/favorite_remote_data_source.dart';
import 'package:program_language_project/src/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:program_language_project/src/features/favorite/domain/use_cases/delete_favorite_uc.dart';
import 'package:program_language_project/src/features/favorite/domain/use_cases/get_favorite_uc.dart';
import 'package:program_language_project/src/features/favorite/domain/use_cases/get_favorites_uc.dart';
import 'package:program_language_project/src/features/favorite/domain/use_cases/set_favorite_uc.dart';
import 'package:program_language_project/src/features/favorite/presentation/manger/favorite_bloc.dart';

import '../../features/favorite/data/repositories/favorite_repository_impl.dart';

Future<void> initializeFavoriteServices(GetIt sl) async {
  ///Data Source
  sl.registerLazySingleton<FavoriteRemoteDataSource>(
      () => FavoriteRemoteDataSourceImpl(http: sl()));

  /// Repository
  sl.registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepositoryImpl(dataSource: sl()));

  /// Use Cases
  sl.registerLazySingleton<GetFavoritesUC>(
      () => GetFavoritesUC(repository: sl()));
  sl.registerLazySingleton<GetFavoriteUC>(
      () => GetFavoriteUC(repository: sl()));
  sl.registerLazySingleton<SetFavoriteUC>(
      () => SetFavoriteUC(repository: sl()));
  sl.registerLazySingleton<DeleteFavoriteUC>(
      () => DeleteFavoriteUC(repository: sl()));

  /// State Management
  sl.registerFactory<FavoriteBloc>(
    () => FavoriteBloc(
      getFavoritesUC: sl(),
      getFavoriteUC: sl(),
      setFavoriteUC: sl(),
      deleteFavoriteUC: sl()
    ),
  );
}
