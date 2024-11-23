// import 'package:get_it/get_it.dart';
//
// import '../../features/categories/data/datasources/categories_local_data_source.dart';
// import '../../features/categories/data/repositories/categories_internal_repository.dart';
// import '../../features/categories/domain/repositories/categories_repository.dart';
// import '../../features/categories/domain/use_cases/add_category_uc.dart';
// import '../../features/categories/domain/use_cases/delete_category_uc.dart';
// import '../../features/categories/domain/use_cases/load_income_categories_uc.dart';
// import '../../features/categories/domain/use_cases/load_payment_categories_uc.dart';
// import '../../features/categories/presentation/manager/categories_bloc.dart';
//
// Future<void> initializeCategoryServices(GetIt sl) async {
//   sl.registerLazySingleton<CategoriesLocalDataSource>(
//       () => CategoriesLocalDataSourceImpl(db: sl()));
//
//   sl.registerLazySingleton<CategoriesRepository>(
//       () => CategoriesInternalRepository(localDataSource: sl()));
//
//   sl.registerLazySingleton<LoadPaymentCategoriesUc>(
//       () => LoadPaymentCategoriesUc(repository: sl()));
//
//   sl.registerLazySingleton<LoadIncomeCategoriesUc>(
//       () => LoadIncomeCategoriesUc(repository: sl()));
//
//   sl.registerLazySingleton<AddCategoryUc>(
//       () => AddCategoryUc(repository: sl()));
//
//   sl.registerLazySingleton<DeleteCategoryUc>(
//       () => DeleteCategoryUc(repository: sl()));
//
//   sl.registerFactory<CategoriesBloc>(
//     () => CategoriesBloc(
//       loadPaymentCategoriesUc: LoadPaymentCategoriesUc(repository: sl()),
//       loadIncomeCategoriesUc: LoadIncomeCategoriesUc(repository: sl()),
//       deleteCategoryUc: DeleteCategoryUc(repository: sl()),
//       addCategoryUc: AddCategoryUc(repository: sl()),
//     ),
//   );
// }
