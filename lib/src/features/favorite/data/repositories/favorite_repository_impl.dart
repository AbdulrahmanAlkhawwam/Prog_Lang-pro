import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/app.dart';

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

  @override
  Future<Either<Failure, bool>> getFavorite(int id) async =>
      await AppUtils.safeCall(() async => await dataSource.getFavorite(id));

  @override
  Future<Either<Failure, void>> deleteFavorite(int id) async =>
      await AppUtils.safeCall(() async => await dataSource.deleteFavorite(id));

  @override
  Future<Either<Failure, void>> setFavorite(int id) async =>
      await AppUtils.safeCall(() async => await dataSource.setFavorite(id));
}
