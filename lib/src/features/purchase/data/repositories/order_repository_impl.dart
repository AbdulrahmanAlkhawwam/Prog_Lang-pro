import 'package:dartz/dartz.dart' hide Order;

import 'package:program_language_project/src/core/errors/failures.dart';
import 'package:program_language_project/src/core/utils/app_util.dart';
import 'package:program_language_project/src/features/purchase/data/data_source/order_remote_data_source.dart';

import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderRemoteDataSource dataSource;

  OrderRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Order>>> getOrders() async =>
      await AppUtils.safeCall(() async => await dataSource.getOrders());
}
