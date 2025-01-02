import 'package:dartz/dartz.dart' hide Order;

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../data_source/order_remote_data_source.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderRemoteDataSource dataSource;

  OrderRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Order>>> getOrders() async =>
      await AppUtils.safeCall(() async => await dataSource.getOrders());
}
