import 'package:get_it/get_it.dart';

import '../../features/datasources/products/product_remote_datasource.dart';
import '../../features/mangers/products/product_bloc.dart';
import '../../features/repositories/products/product_repository.dart';

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
