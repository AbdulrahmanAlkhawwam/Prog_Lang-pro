import 'package:get_it/get_it.dart';

import '../../features/home/data/data_source/main_remote_datasource.dart';
import '../../features/home/domain/repositories/main_repository.dart';
import '../../features/home/presentation/manger/cubit/main/main_cubit.dart';
import '../../features/home/data/repositories/main_repository_impl.dart';

Future<void> initializeMainServices(GetIt sl) async {
  /// Data Source
  sl.registerLazySingleton<MainRemoteDatasource>(
      () => MainRemoteDatasourceImpl(http: sl()));

  /// Repository
  sl.registerLazySingleton<MainRepository>(
      () => MainRepositoryImpl(datasource: sl()));

  /// State Management
  sl.registerFactory<MainCubit>(
    () => MainCubit(repository: sl()),
  );
}
