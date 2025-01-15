import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/features/home/domain/repositories/user_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/user.dart';

class GetAccountUC extends UseCaseNoParam<User> {
  final UserRepository repository;

  GetAccountUC({required this.repository});

  @override
  Future<Either<Failure, User>> call() async {
    return await repository.getAccount();
  }
}
