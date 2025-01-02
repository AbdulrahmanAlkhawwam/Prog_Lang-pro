import 'package:get_it/get_it.dart';

import '../../features/shop/data/data_source/shop_remote_datasource.dart';
import '../../features/shop/data/repositories/Shop_repository_impl.dart';
import '../../features/shop/domain/repositories/Shop_repository.dart';
import '../../features/shop/domain/use_cases/get_shop_details_uc.dart';
import '../../features/shop/domain/use_cases/get_shops_uc.dart';
import '../../features/shop/presentation/manger/shop_bloc.dart';

Future<void> initializeShopServices(GetIt sl) async {
  /// Data Source
  sl.registerLazySingleton<ShopRemoteDatasource>(
    () => ShopRemoteDatasourceImpl(http: sl()),
  );

  /// Repository
  sl.registerLazySingleton<ShopRepository>(
    () => ShopRepositoryImpl(datasource: sl()),
  );

  /// Use Cases
  sl.registerLazySingleton<GetShopDetailsUC>(
      () => GetShopDetailsUC(repository: sl()));
  sl.registerLazySingleton<GetShopsUC>(() => GetShopsUC(repository: sl()));

  /// State Management
  sl.registerFactory<ShopBloc>(
    () => ShopBloc(
      getShopDetailsUC: sl(),
      getShopsUC: sl(),
      repository: sl(),
    ),
  );
}
