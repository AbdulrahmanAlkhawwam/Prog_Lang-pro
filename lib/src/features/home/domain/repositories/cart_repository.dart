import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../product/domain/entities/product.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> addToCart(Product product);

  Future<Either<Failure, List<Product>>> getCart();
}
