import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/auth_repository.dart';

class SaveTokenUC extends UseCase<void, String> {
  final AuthRepository repository;

  SaveTokenUC({required this.repository});

  @override
  Future<Either<Failure, void>> call({required String param}) {
    return repository.saveToken(param);
  }
}
