import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/auth_repository.dart';

class LogoutUC extends UseCaseNoParam{
  final AuthRepository repository ;

  LogoutUC({required this.repository});

  @override
  Future<Either<Failure, void>> call() async{
    return await repository.logout();
  }

}