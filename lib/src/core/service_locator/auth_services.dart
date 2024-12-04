import 'package:get_it/get_it.dart';
import 'package:program_language_project/src/features/datasources/auth/auth_remote_datasource.dart';
import 'package:program_language_project/src/features/mangers/auth/auth_bloc.dart';
import 'package:program_language_project/src/features/repositories/auth/auth_repository.dart';

Future<void> initializeAuthServices(GetIt sl) async {
  sl.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(http: sl()));

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(datasource: sl()));

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(repository: sl()),
  );
}
