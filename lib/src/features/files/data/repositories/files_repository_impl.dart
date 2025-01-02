import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../domain/repositories/files_repository.dart';
import '../data_sources/files_remote_data_source.dart';

class FilesRepositoryImpl extends FilesRepository {
  final FilesRemoteDataSource dataSource;

  FilesRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, void>> uploadImage(File file) async {
    return AppUtils.safeCall(() async => dataSource.uploadImage(file, ""));
  }

  @override
  Future<Either<Failure, void>> deleteImage() async =>
      await AppUtils.safeCall(() async => await dataSource.deleteImage());
}
