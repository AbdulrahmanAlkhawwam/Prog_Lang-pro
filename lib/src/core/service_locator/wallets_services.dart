import 'package:get_it/get_it.dart';
import 'package:program_language_project/src/features/datasources/products/products_remote_datasource.dart';
import 'package:program_language_project/src/features/mangers/test_bloc.dart';
import 'package:program_language_project/src/features/repositories/products/product_repository.dart';

Future<void> initializeWalletServices(GetIt sl) async {
  sl.registerLazySingleton<ProductsRemoteDatasource>(
    () => ProductsRemoteDatasourceImpl(http: sl()),
  );

  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepository(datasource: sl()));

  sl.registerFactory<TestBloc>(
    () => TestBloc(repository: sl()),
  );
}
//
