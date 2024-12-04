import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/core/utils/app_util.dart';
import 'package:program_language_project/src/features/datasources/auth/auth_remote_datasource.dart';

import '../../../core/errors/failures.dart';
import '../../models/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String phoneNumber, String password);
}

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource datasource;

  AuthRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, User>> login(
      String phoneNumber, String password) async {
    return await AppUtils.safeCall(
      () => datasource.login(
        phoneNumber,
        password,
      ),
    );
  }
}
