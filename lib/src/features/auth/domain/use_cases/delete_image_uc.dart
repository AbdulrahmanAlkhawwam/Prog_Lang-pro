import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/core/errors/failures.dart';
import 'package:program_language_project/src/core/use_case/use_case.dart';
import 'package:program_language_project/src/features/auth/domain/repositories/auth_repository.dart';

class DeleteImageUC extends UseCase<void, void> {
  final AuthRepository repository;

  DeleteImageUC({required this.repository});

  @override
  Future<Either<Failure, void>> call({required void param}) async {
    return await repository.deleteImage();
  }
}
