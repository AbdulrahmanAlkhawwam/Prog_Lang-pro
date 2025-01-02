import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repositories/files_repository.dart';

class UploadImageUC extends UseCase<void, File> {
  final FilesRepository repository;

  UploadImageUC({required this.repository});

  @override
  Future<Either<Failure, void>> call({required File param}) async {
    return await repository.uploadImage(param);
  }
}
