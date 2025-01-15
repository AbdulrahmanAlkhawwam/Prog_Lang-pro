import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/features/home/domain/repositories/user_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';

class DeleteAccountUC extends UseCaseNoParam {
  final UserRepository repository ;

  DeleteAccountUC({required this.repository});

  @override
  Future<Either<Failure, void>> call() async{
    return await repository.deleteAccount();
  }
}