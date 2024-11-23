// import 'package:get_it/get_it.dart';
//
// import '../../features/operations/data/data_sources/operations_local_data_source.dart';
// import '../../features/operations/data/repositories/operations_internal_repository.dart';
// import '../../features/operations/domain/repositories/operations_repository.dart';
// import '../../features/operations/domain/use_cases/add_operation_uc.dart';
// import '../../features/operations/domain/use_cases/delete_operation_uc.dart';
// import '../../features/operations/domain/use_cases/load_category_operation_uc.dart';
// import '../../features/operations/domain/use_cases/load_operations_uc.dart';
// import '../../features/operations/domain/use_cases/load_wallet_operation_uc.dart';
// import '../../features/operations/presentation/manager/operation_bloc.dart';
//
// Future<void> initializeOperationServices(GetIt sl) async {
//   sl.registerLazySingleton<OperationsLocalDataSource>(
//     () => OperationsLocalDataSourceImpl(db: sl()),
//   );
//
//   sl.registerLazySingleton<OperationsRepository>(
//       () => OperationsInternalRepository(localDataSource: sl()));
//
//   sl.registerLazySingleton<AddOperationUc>(
//       () => AddOperationUc(repository: sl()));
//
//   sl.registerLazySingleton<DeleteOperationUc>(
//       () => DeleteOperationUc(repository: sl()));
//
//   sl.registerLazySingleton<LoadOperationsUc>(
//       () => LoadOperationsUc(repository: sl()));
//
//   sl.registerLazySingleton<LoadCategoryOperationUc>(
//       () => LoadCategoryOperationUc(repository: sl()));
//
//   sl.registerLazySingleton<LoadWalletOperationUc>(
//       () => LoadWalletOperationUc(repository: sl()));
//
//   sl.registerFactory<OperationBloc>(
//     () => OperationBloc(
//       loadOperationsUc: LoadOperationsUc(repository: sl()),
//       loadCategoryOperationUc: LoadCategoryOperationUc(repository: sl()),
//       loadWalletOperationUc: LoadWalletOperationUc(repository: sl()),
//       deleteOperationUc: DeleteOperationUc(repository: sl()),
//       addOperationUc: AddOperationUc(repository: sl()),
//     ),
//   );
// }
