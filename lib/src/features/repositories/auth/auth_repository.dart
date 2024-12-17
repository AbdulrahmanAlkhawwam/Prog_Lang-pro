import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/core/utils/app_util.dart';
import 'package:program_language_project/src/features/datasources/auth/auth_local_datasource.dart';
import 'package:program_language_project/src/features/datasources/auth/auth_remote_datasource.dart';

import '../../../core/errors/failures.dart';
import '../../models/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String phoneNumber, String password);

  Future<Either<Failure, bool>> otp(String passkey);

  Future<Either<Failure, bool>> checkToken();

  Future<Either<Failure, void>> saveToken(String token);
}

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource datasource;
  final AuthLocalDatasource storage;

  AuthRepositoryImpl({required this.datasource, required this.storage});

  @override
  Future<Either<Failure, User>> login(
          String phoneNumber, String password) async =>
      await AppUtils.safeCall(() => datasource.login(phoneNumber, password));

  @override
  Future<Either<Failure, bool>> otp(String passkey) async {
    return await AppUtils.safeCall(() async => await datasource.otp(passkey));
  }

  @override
  Future<Either<Failure, bool>> checkToken() async =>
      await AppUtils.safeCall(() => storage.checkToken());

  @override
  Future<Either<Failure, void>> saveToken(String token) async =>
      await AppUtils.safeCall(() => storage.saveToken(token));
}
