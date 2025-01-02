import 'package:dartz/dartz.dart';

import '../repositories/files_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';

class DeleteImageUC extends UseCaseNoParam {
  final FilesRepository repository;

  DeleteImageUC({required this.repository});

  @override
  Future<Either<Failure, void>> call() async {
    return await repository.deleteImage();
  }
}
