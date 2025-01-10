import 'package:dartz/dartz.dart' hide Order;

import '../../../../core/errors/failures.dart';
import '../../../order/domain/entities/order.dart';
import '../../../product/domain/entities/product.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> addToCart(Product product);

  Future<Either<Failure, List<Product>>> getCart();

  Future<Either<Failure, Order>> createOrder();
}
