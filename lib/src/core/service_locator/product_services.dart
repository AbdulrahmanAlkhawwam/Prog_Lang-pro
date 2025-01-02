import 'package:get_it/get_it.dart';

import '../../features/product/data/data_source/product_remote_datasource.dart';
import '../../features/product/data/repositories/product_repository_impl.dart';
import '../../features/product/domain/repositories/product_repository.dart';
import '../../features/product/presentation/manger/product_bloc.dart';

Future<void> initializeProductServices(GetIt sl) async {
  /// Data Source
  sl.registerLazySingleton<ProductRemoteDatasource>(
    () => ProductRemoteDatasourceImpl(http: sl()),
  );

  /// Repository
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(datasource: sl()));

  /// State Management
  sl.registerFactory<ProductBloc>(
    () => ProductBloc(repository: sl()),
  );
}
//
