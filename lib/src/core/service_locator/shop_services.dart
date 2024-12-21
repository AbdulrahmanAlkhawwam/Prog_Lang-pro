import 'package:get_it/get_it.dart';

import '../../features/datasources/shops/shop_remote_datasource.dart';
import '../../features/mangers/shops/shop_bloc.dart';
import '../../features/repositories/shops/Shop_repository.dart';

Future<void> initializeShopServices(GetIt sl) async {
  sl.registerLazySingleton<ShopRemoteDatasource>(
    () => ShopRemoteDatasourceImpl(http: sl()),
  );

  sl.registerLazySingleton<ShopRepository>(
      () => ShopRepository(datasource: sl()));

  sl.registerFactory<ShopBloc>(
    () => ShopBloc(repository: sl()),
  );
}
//
