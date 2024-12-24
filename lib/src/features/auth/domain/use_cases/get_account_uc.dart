import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetAccountUC extends UseCaseNoParam<User> {
  final AuthRepository repository;

  GetAccountUC({required this.repository});

  @override
  Future<Either<Failure, User>> call() async {
    return await repository.getAccount();
  }
}
