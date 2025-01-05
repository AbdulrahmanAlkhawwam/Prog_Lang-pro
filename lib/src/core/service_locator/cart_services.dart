import 'package:get_it/get_it.dart';
import 'package:program_language_project/src/features/home/data/data_source/cart_local_data_source.dart';
import 'package:program_language_project/src/features/home/presentation/manger/cubit/cart/cart_cubit.dart';

import '../../features/home/data/data_source/settings_remote_data_source.dart';
import '../../features/home/data/repositories/cart_repository_impl.dart';
import '../../features/home/data/repositories/settings_repository_impl.dart';
import '../../features/home/domain/repositories/cart_repository.dart';
import '../../features/home/domain/repositories/settings_repository.dart';
import '../../features/home/domain/use_cases/theme_uc.dart';
import '../../features/home/presentation/manger/theme_notifier.dart';

Future<void> initializeCartServices(GetIt sl) async {
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(database: sl()),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(dataSource: sl()),
  );

  sl.registerLazySingleton<CartCubit>(() => CartCubit(repository: sl()));
}
