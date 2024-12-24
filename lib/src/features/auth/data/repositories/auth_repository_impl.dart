import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/edit_account_uc.dart';
import '../../domain/use_cases/login_uc.dart';
import '../../domain/use_cases/register_uc.dart';
import '../data_source/auth_local_data_source.dart';
import '../data_source/auth_remote_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource datasource;
  final AuthLocalDataSource storage;

  AuthRepositoryImpl({required this.datasource, required this.storage});

  @override
  Future<Either<Failure, bool>> checkToken() async =>
      await AppUtils.safeCall(() => storage.checkToken());

  @override
  Future<Either<Failure, void>> deleteToken() async =>
      await AppUtils.safeCall(() async => await storage.deleteToken());

  @override
  Future<Either<Failure, void>> deleteAccount() async =>
      await AppUtils.safeCall(() async => await datasource.deleteAccount());

  @override
  Future<Either<Failure, User>> editAccount(EditAccountParam param) async =>
      await AppUtils.safeCall(() async => await datasource.editAccount(param));

  @override
  Future<Either<Failure, User>> getAccount() async =>
      await AppUtils.safeCall(() async => await datasource.getAccount());

  @override
  Future<Either<Failure, User>> login(LoginParam param) async =>
      await AppUtils.safeCall(() => datasource.login(param));

  @override
  Future<Either<Failure, void>> logout() async =>
      await AppUtils.safeCall(() async => await datasource.logout());

  @override
  Future<Either<Failure, bool>> otp(String passkey) async =>
      await AppUtils.safeCall(() async => await datasource.otp(passkey));

  @override
  Future<Either<Failure, User>> register(RegisterParam param) async =>
      await AppUtils.safeCall(
        () async => await datasource.register(param),
      );

  @override
  Future<Either<Failure, void>> saveToken(String token) async =>
      await AppUtils.safeCall(() => storage.saveToken(token));
}
