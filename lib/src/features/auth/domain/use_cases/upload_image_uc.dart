import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/core/errors/failures.dart';
import 'package:program_language_project/src/core/use_case/use_case.dart';
import 'package:program_language_project/src/features/auth/domain/repositories/auth_repository.dart';

class UploadImageUC extends UseCase<void,File>{
  final AuthRepository repository ;

  UploadImageUC({required this.repository})
;

  @override
  Future<Either<Failure, void>> call({required File? param}) async{
    return await repository.uploadImage(param);
  }
}