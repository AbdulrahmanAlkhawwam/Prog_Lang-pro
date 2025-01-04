import 'package:get_it/get_it.dart';
import 'package:program_language_project/src/features/home/data/data_source/user_remote_data_source.dart';
import 'package:program_language_project/src/features/home/domain/repositories/user_repository.dart';

import '../../features/home/data/repositories/user_repository_impl.dart';
import '../../features/home/domain/use_cases/delete_account_uc.dart';
import '../../features/home/domain/use_cases/edit_account_uc.dart';
import '../../features/home/domain/use_cases/get_account_uc.dart';
import '../../features/home/presentation/manger/bloc/user_bloc.dart';

Future<void> initializeUserServices(GetIt sl) async {
  ///Data Source
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(http: sl()));

  /// Repository
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(dataSource: sl()));

  /// Use Cases
  sl.registerLazySingleton<DeleteAccountUC>(
      () => DeleteAccountUC(repository: sl()));
  sl.registerLazySingleton<EditAccountUC>(
      () => EditAccountUC(repository: sl()));
  sl.registerLazySingleton<GetAccountUC>(() => GetAccountUC(repository: sl()));

  /// State Management
  sl.registerFactory<UserBloc>(
    () => UserBloc(
      deleteAccountUC: sl(),
      editAccountUc: sl(),
      getAccountUc: sl(),
    ),
  );
}
