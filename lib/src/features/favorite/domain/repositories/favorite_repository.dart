import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../product/domain/entities/product.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, List<Product>>> getFavorites();

  Future<Either<Failure, bool>> getFavorite(int id);

  Future<Either<Failure, void>> setFavorite(int id);

  Future<Either<Failure, void>> deleteFavorite(int id);
}
