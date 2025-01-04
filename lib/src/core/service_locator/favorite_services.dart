import 'package:get_it/get_it.dart';
import 'package:program_language_project/src/features/favorite/data/data_source/favorite_remote_data_source.dart';
import 'package:program_language_project/src/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:program_language_project/src/features/favorite/domain/use_cases/get_favorites_uc.dart';
import 'package:program_language_project/src/features/favorite/presentation/manger/favorite_bloc.dart';
import 'package:program_language_project/src/features/home/data/data_source/user_remote_data_source.dart';
import 'package:program_language_project/src/features/home/domain/repositories/user_repository.dart';

import '../../features/favorite/data/repositories/favorite_repository_impl.dart';
import '../../features/home/data/repositories/user_repository_impl.dart';
import '../../features/home/domain/use_cases/delete_account_uc.dart';
import '../../features/home/domain/use_cases/edit_account_uc.dart';
import '../../features/home/domain/use_cases/get_account_uc.dart';
import '../../features/home/presentation/manger/bloc/user_bloc.dart';

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

  /// State Management
  sl.registerFactory<FavoriteBloc>(
    () => FavoriteBloc(getFavoritesUC: sl()),
  );
}
