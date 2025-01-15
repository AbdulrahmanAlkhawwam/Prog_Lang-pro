import 'package:get_it/get_it.dart';
import 'package:program_language_project/src/features/home/data/data_source/cart_local_data_source.dart';
import 'package:program_language_project/src/features/home/presentation/manger/bloc/cart/cart_bloc.dart';

import '../../features/home/data/data_source/cart_remote_data_source.dart';
import '../../features/home/data/repositories/cart_repository_impl.dart';
import '../../features/home/domain/repositories/cart_repository.dart';

Future<void> initializeCartServices(GetIt sl) async {
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(database: sl()),
  );
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(http: sl(), storage: sl()),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(dataSource: sl(), remote: sl()),
  );

  sl.registerFactory<CartBloc>(() => CartBloc(repository: sl()));
}
