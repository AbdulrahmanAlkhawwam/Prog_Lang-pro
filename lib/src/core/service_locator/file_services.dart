import 'package:get_it/get_it.dart';

import '../../features/files/data/data_sources/files_remote_data_source.dart';
import '../../features/files/data/repositories/files_repository_impl.dart';
import '../../features/files/domain/repositories/files_repository.dart';
import '../../features/files/domain/use_cases/delete_image_uc.dart';
import '../../features/files/domain/use_cases/upload_image_uc.dart';
import '../../features/files/presentation/bloc/file_bloc.dart';

Future<void> initializeFileServices(GetIt sl) async {
  ///Data Source
  sl.registerLazySingleton<FilesRemoteDataSource>(
      () => FilesRemoteDataSourceImpl(
            http: sl(),
            storage: sl(),
            multipartHttp: sl(),
          ));

  /// Repository
  sl.registerLazySingleton<FilesRepository>(
      () => FilesRepositoryImpl(dataSource: sl()));

  /// Use Cases
  sl.registerLazySingleton<DeleteImageUC>(
      () => DeleteImageUC(repository: sl()));
  sl.registerLazySingleton<UploadImageUC>(
      () => UploadImageUC(repository: sl()));

  /// State Management
  sl.registerFactory<FileBloc>(
    () => FileBloc(
      deleteImageUC: sl(),
      uploadImageUC: sl(),
    ),
  );
}
