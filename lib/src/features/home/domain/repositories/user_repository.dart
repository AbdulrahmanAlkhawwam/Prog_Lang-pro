import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../use_cases/edit_account_uc.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> deleteAccount();

  Future<Either<Failure, User>> editAccount(EditAccountParam param);

  Future<Either<Failure, User>> getAccount();
}
