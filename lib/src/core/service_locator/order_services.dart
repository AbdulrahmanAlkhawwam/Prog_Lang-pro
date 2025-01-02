import 'package:get_it/get_it.dart';

import '../../features/order/data/data_source/order_remote_data_source.dart';
import '../../features/order/data/repositories/order_repository_impl.dart';
import '../../features/order/domain/repositories/order_repository.dart';
import '../../features/order/presentation/manger/order_bloc.dart';

Future<void> initializeOrderServices(GetIt sl) async {
  /// Data Source
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(http: sl()),
  );

  /// Repository
  sl.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(dataSource: sl()));

  /// State Management
  sl.registerFactory<OrderBloc>(
    () => OrderBloc(repository: sl()),
  );
}
