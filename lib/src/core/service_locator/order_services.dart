import 'package:get_it/get_it.dart';
import 'package:program_language_project/src/features/purchase/data/data_source/order_remote_data_source.dart';

import '../../features/purchase/data/repositories/order_repository_impl.dart';
import '../../features/purchase/domain/repositories/order_repository.dart';

Future<void> initializeOrderServices(GetIt sl) async {
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(http: sl()),
  );

  sl.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(dataSource: sl()));

  sl.registerFactory<OrderBloc>(
    () => OrderBloc(repository: sl()),
  );
}
//
