import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/use_cases/edit_account_uc.dart';
import '../data_source/user_remote_data_source.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource dataSource;

  UserRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, void>> deleteAccount() async =>
      await AppUtils.safeCall(() async => await dataSource.deleteAccount());

  @override
  Future<Either<Failure, User>> editAccount(EditAccountParam param) async =>
      await AppUtils.safeCall(() async => await dataSource.editAccount(param));

  @override
  Future<Either<Failure, User>> getAccount() async =>
      await AppUtils.safeCall(() async => await dataSource.getAccount());
}
