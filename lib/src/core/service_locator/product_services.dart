import 'package:get_it/get_it.dart';

import '../../features/product/data/data_source/product_remote_datasource.dart';
import '../../features/product/data/repositories/product_repository_impl.dart';
import '../../features/product/domain/repositories/product_repository.dart';
import '../../features/product/presentation/manger/product_bloc.dart';

Future<void> initializeProductServices(GetIt sl) async {
  sl.registerLazySingleton<ProductRemoteDatasource>(
    () => ProductRemoteDatasourceImpl(http: sl()),
  );

  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(datasource: sl()));

  sl.registerFactory<ProductBloc>(
    () => ProductBloc(repository: sl()),
  );
}
//
