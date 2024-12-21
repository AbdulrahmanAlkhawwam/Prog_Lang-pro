import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/core/utils/app_util.dart';
import 'package:program_language_project/src/features/datasources/auth/auth_local_datasource.dart';
import 'package:program_language_project/src/features/datasources/auth/auth_remote_datasource.dart';

import '../../../core/errors/failures.dart';
import '../../models/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(
    String phoneNumber,
    String password,
  );

  Future<Either<Failure, User>> register(
    String firstName,
    String lastName,
    String phoneNumber,
    String password,
  );

  Future<Either<Failure, bool>> otp(String passkey);

  Future<Either<Failure, bool>> checkToken();

  Future<Either<Failure, void>> saveToken(String token);

  Future<Either<Failure, void>> deleteToken();

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, void>> delete();

  Future<Either<Failure, User>> me();
}

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource datasource;
  final AuthLocalDatasource storage;

  AuthRepositoryImpl({required this.datasource, required this.storage});

  @override
  Future<Either<Failure, User>> login(
          String phoneNumber, String password) async =>
      await AppUtils.safeCall(
        () => datasource.login(
          phoneNumber,
          password,
        ),
      );

  @override
  Future<Either<Failure, User>> register(
    String firstName,
    String lastName,
    String phoneNumber,
    String password,
  ) async {
    return await AppUtils.safeCall(
      () async => await datasource.register(
        firstName,
        lastName,
        password,
        phoneNumber,
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> otp(String passkey) async {
    return await AppUtils.safeCall(() async => await datasource.otp(passkey));
  }

  @override
  Future<Either<Failure, bool>> checkToken() async {
    return await AppUtils.safeCall(() => storage.checkToken());
  }

  @override
  Future<Either<Failure, User>> me() async {
    return await AppUtils.safeCall(() async => await datasource.me());
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return await AppUtils.safeCall(() async => await datasource.logout());
  }

  @override
  Future<Either<Failure, void>> saveToken(String token) async {
    return await AppUtils.safeCall(() => storage.saveToken(token));
  }

  @override
  Future<Either<Failure, void>> deleteToken() async {
    return await AppUtils.safeCall(() async => await storage.deleteToken());
  }

  @override
  Future<Either<Failure, void>> delete() async {
    return await AppUtils.safeCall(
        () async => await datasource.deleteAccount());
  }
}
