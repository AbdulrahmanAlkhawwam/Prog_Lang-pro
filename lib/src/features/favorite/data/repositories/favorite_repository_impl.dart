import 'package:dartz/dartz.dart';

import 'package:program_language_project/src/core/errors/failures.dart';
import 'package:program_language_project/src/core/utils/app_util.dart';

import 'package:program_language_project/src/features/product/domain/entities/product.dart';

import '../../domain/repositories/favorite_repository.dart';
import '../data_source/favorite_remote_data_source.dart';

class FavoriteRepositoryImpl extends FavoriteRepository {
  final FavoriteRemoteDataSource dataSource;

  FavoriteRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Product>>> getFavorites() async =>
      await AppUtils.safeCall(() async => await dataSource.getFavorites());
}
