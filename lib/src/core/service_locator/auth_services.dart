import 'package:get_it/get_it.dart';
import 'package:program_language_project/src/features/auth/domain/use_cases/delete_image_uc.dart';
import 'package:program_language_project/src/features/auth/domain/use_cases/upload_image_uc.dart';

import '../../features/auth/data/data_source/auth_local_data_source.dart';
import '../../features/auth/data/data_source/auth_remote_data_source.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/use_cases/check_token_uc.dart';
import '../../features/auth/domain/use_cases/delete_account_uc.dart';
import '../../features/auth/domain/use_cases/delete_token_uc.dart';
import '../../features/auth/domain/use_cases/edit_account_uc.dart';
import '../../features/auth/domain/use_cases/get_account_uc.dart';
import '../../features/auth/domain/use_cases/login_uc.dart';
import '../../features/auth/domain/use_cases/logout_uc.dart';
import '../../features/auth/domain/use_cases/otp_uc.dart';
import '../../features/auth/domain/use_cases/register_uc.dart';
import '../../features/auth/domain/use_cases/save_token_uc.dart';
import '../../features/auth/presentation/manger/bloc/auth_bloc.dart';
import '../../features/auth/presentation/manger/cubit/auth_pres_cubit.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';

Future<void> initializeAuthServices(GetIt sl) async {
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(http: sl()));

  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(storage: sl()));

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(datasource: sl(), storage: sl()));

  sl.registerLazySingleton<CheckTokenUC>(() => CheckTokenUC(repository: sl()));
  sl.registerLazySingleton<DeleteAccountUC>(
      () => DeleteAccountUC(repository: sl()));
  sl.registerLazySingleton<DeleteImageUC>(
      () => DeleteImageUC(repository: sl()));
  sl.registerLazySingleton<DeleteTokenUC>(
      () => DeleteTokenUC(repository: sl()));
  sl.registerLazySingleton<EditAccountUC>(
      () => EditAccountUC(repository: sl()));
  sl.registerLazySingleton<GetAccountUC>(() => GetAccountUC(repository: sl()));
  sl.registerLazySingleton<LoginUC>(() => LoginUC(repository: sl()));
  sl.registerLazySingleton<LogoutUC>(() => LogoutUC(repository: sl()));
  sl.registerLazySingleton<OtpUC>(() => OtpUC(repository: sl()));
  sl.registerLazySingleton<RegisterUC>(() => RegisterUC(repository: sl()));
  sl.registerLazySingleton<SaveTokenUC>(() => SaveTokenUC(repository: sl()));
  sl.registerLazySingleton<UploadImageUC>(
      () => UploadImageUC(repository: sl()));

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      checkTokenUC: sl(),
      deleteAccountUC: sl(),
      deleteImageUC: sl(),
      deleteTokenUC: sl(),
      editAccountUc: sl(),
      getAccountUc: sl(),
      loginUC: sl(),
      logoutUC: sl(),
      otpUC: sl(),
      registerUC: sl(),
      saveTokenUC: sl(),
      uploadImageUC: sl(),
    ),
  );
  sl.registerFactory<AuthPresCubit>(
    () => AuthPresCubit(),
  );
}
