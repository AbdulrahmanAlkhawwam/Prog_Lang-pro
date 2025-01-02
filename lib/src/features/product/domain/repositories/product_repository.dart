import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../shop/domain/entities/category.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  // Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, List<Product>>> getShopProducts(int shopId);

  Future<Either<Failure, List<Category>>> getCategories();
}
