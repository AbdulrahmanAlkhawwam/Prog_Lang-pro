import 'package:dartz/dartz.dart' hide Order;
import 'package:program_language_project/src/core/errors/failures.dart';

import '../entities/order.dart';
abstract class OrderRepository {
  Future<Either<Failure, List<Order>>> getOrders();
}
