import 'package:get_it/get_it.dart';
import 'package:program_language_project/src/features/datasources/products/product_remote_datasource.dart';
import 'package:program_language_project/src/features/mangers/product_bloc.dart';
import 'package:program_language_project/src/features/repositories/products/product_repository.dart';

Future<void> initializeProductServices(GetIt sl) async {
  sl.registerLazySingleton<ProductRemoteDatasource>(
    () => ProductRemoteDatasourceImpl(http: sl()),
  );

  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepository(datasource: sl()));

  sl.registerFactory<ProductBloc>(
    () => ProductBloc(repository: sl()),
  );
}
//
