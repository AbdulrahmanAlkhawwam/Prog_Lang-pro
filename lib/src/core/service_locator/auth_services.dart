import 'package:get_it/get_it.dart';
import 'package:program_language_project/src/features/datasources/auth/auth_remote_datasource.dart';
import 'package:program_language_project/src/features/mangers/auth/auth_bloc.dart';

Future<void> initializeAuthServices(GetIt sl) async {
  sl.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(http: sl()));

  // sl.registerLazySingleton<CategoriesRepository>(
  //     () => CategoriesInternalRepository(localDataSource: sl()));
  //
  // sl.registerLazySingleton<LoadPaymentCategoriesUc>(
  //     () => LoadPaymentCategoriesUc(repository: sl()));
  //
  // sl.registerLazySingleton<LoadIncomeCategoriesUc>(
  //     () => LoadIncomeCategoriesUc(repository: sl()));
  //
  // sl.registerLazySingleton<AddCategoryUc>(
  //     () => AddCategoryUc(repository: sl()));
  //
  // sl.registerLazySingleton<DeleteCategoryUc>(
  //     () => DeleteCategoryUc(repository: sl()));
  //
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(datasource: sl()),
  );
}
