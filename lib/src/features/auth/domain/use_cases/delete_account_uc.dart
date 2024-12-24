import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/auth_repository.dart';

class DeleteAccountUC extends UseCaseNoParam {
  final AuthRepository repository ;

  DeleteAccountUC({required this.repository});

  @override
  Future<Either<Failure, void>> call() async{
    return await repository.deleteAccount();
  }
}