import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../product/domain/entities/product.dart';

abstract class FavoriteRepository {

  Future<Either<Failure,List<Product>>> getFavorites ();
}

