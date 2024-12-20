import 'package:get_it/get_it.dart';

import '../../features/datasources/shops/shops_remote_datasource.dart';
import '../../features/mangers/shops/shops_bloc.dart';
import '../../features/repositories/shops_details/shops_repository.dart';


Future<void> initializeShopServices(GetIt sl) async {
  sl.registerLazySingleton<ShopsRemoteDatasorce>(
        () => ShopsRemoteDatasourceImpl(http: sl()),
  );

  sl.registerLazySingleton<ShopsDetailsRepository>(
          () => ShopsDetailsRepository(datasource: sl()));

  sl.registerFactory<ShopsBloc>(
        () => ShopsBloc(repository: sl()),
  );
}
//
