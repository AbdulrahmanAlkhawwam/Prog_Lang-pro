import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/auth_repository.dart';


class CheckTokenUC extends UseCaseNoParam {
  final AuthRepository repository;

  CheckTokenUC({required this.repository});

  @override
  Future<Either<Failure, bool>> call() async {
    return  await repository.checkToken();
  }
}
