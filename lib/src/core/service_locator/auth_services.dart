import 'package:get_it/get_it.dart';

import '../../features/datasources/auth/auth_remote_datasource.dart';
import '../../features/mangers/auth/bloc/auth_bloc.dart';
import '../../features/mangers/auth/cubit/auth_pres_cubit.dart';
import '../../features/repositories/auth/auth_repository.dart';

Future<void> initializeAuthServices(GetIt sl) async {
  sl.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(http: sl()));

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(datasource: sl()));

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(repository: sl()),
  );
  sl.registerFactory<AuthPresCubit>(
    () => AuthPresCubit(),
  );
}
