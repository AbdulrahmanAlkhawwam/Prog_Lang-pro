import 'package:dartz/dartz.dart' hide Order;
import 'package:program_language_project/src/features/home/data/data_source/cart_remote_data_source.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../../order/domain/entities/order.dart';
import '../../../product/data/models/product_model.dart';
import '../../../product/domain/entities/product.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data_source/cart_local_data_source.dart';

class CartRepositoryImpl extends CartRepository {
  final CartLocalDataSource dataSource;
  final CartRemoteDataSource remote;

  CartRepositoryImpl({
    required this.dataSource,
    required this.remote,
  });

  @override
  Future<Either<Failure, void>> addToCart(Product product) async {
    return await AppUtils.safeCall(() async {
      await dataSource.addToCart(ProductModel.fromEntity(product));
    });
  }

  @override
  Future<Either<Failure, List<Product>>> getCart() async {
    return await AppUtils.safeCall(() async {
      return await dataSource.getCart();
    });
  }

  @override
  Future<Either<Failure, Order>> createOrder() async {
    return await AppUtils.safeCall(() async {
      final products = await dataSource.getCart();
      final response = await remote.createOrder(
          products.map((e) => ProductModel.fromEntity(e)).toList());
      await dataSource.emptyCart();
      return response;
    });
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int id, bool allAmount) async =>
      await AppUtils.safeCall(
          () async => await dataSource.deleteProduct(id, allAmount));
}
