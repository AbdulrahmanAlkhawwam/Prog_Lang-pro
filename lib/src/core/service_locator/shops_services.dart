import 'package:get_it/get_it.dart';

import '../../features/datasources/shops/shops_remote_datasorce.dart';
import '../../features/mangers/shops/Shops_bloc.dart';
import '../../features/repositories/shops/Shops_repository.dart';

Future<void> initializeShopServices(GetIt sl) async {
  sl.registerLazySingleton<ShopsRemoteDatasorce>(
    () => ShopsRemoteDatasourceImpl(http: sl()),
  );

  sl.registerLazySingleton<ShopsRepository>(
      () => ShopsRepository(datasource: sl()));

  sl.registerFactory<ShopsBloc>(
    () => ShopsBloc(repository: sl()),
  );
}
//
