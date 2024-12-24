import 'package:get_it/get_it.dart';

import '../../features/shop/data/data_source/shop_remote_datasource.dart';
import '../../features/shop/data/repositories/Shop_repository_impl.dart';
import '../../features/shop/domain/repositories/Shop_repository.dart';
import '../../features/shop/presentation/manger/shop_bloc.dart';

Future<void> initializeShopServices(GetIt sl) async {
  sl.registerLazySingleton<ShopRemoteDatasource>(
    () => ShopRemoteDatasourceImpl(http: sl()),
  );

  sl.registerLazySingleton<ShopRepository>(
    () => ShopRepositoryImpl(datasource: sl()),
  );

  sl.registerFactory<ShopBloc>(
    () => ShopBloc(repository: sl()),
  );
}
//
