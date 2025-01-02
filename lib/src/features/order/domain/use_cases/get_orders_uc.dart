import 'package:dartz/dartz.dart' hide Order;

import '../../../../core/errors/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrdersUc extends UseCaseNoParam<List<Order>> {
  final OrderRepository repository;

  GetOrdersUc({required this.repository});

  @override
  Future<Either<Failure, List<Order>>> call() async {
    return await repository.getOrders();
  }
}
