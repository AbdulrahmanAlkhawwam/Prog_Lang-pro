import 'package:get_it/get_it.dart';

import '../../features/datasources/main/main_remote_datasource.dart';
import '../../features/mangers/main/cubit/main_cubit.dart';
import '../../features/repositories/main/main_repository.dart';

Future<void> initializeMainServices(GetIt sl) async {
  sl.registerLazySingleton<MainRemoteDatasource>(
      () => MainRemoteDatasourceImpl(http: sl()));

  sl.registerLazySingleton<MainRepository>(
      () => MainRepositoryImpl(datasource: sl()));

  sl.registerFactory<MainCubit>(
    () => MainCubit(repository: sl()),
  );
}
