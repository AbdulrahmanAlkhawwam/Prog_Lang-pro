import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class FilesRepository {
  Future<Either<Failure, void>> uploadImage(File file);

  Future<Either<Failure, void>> deleteImage();
}
