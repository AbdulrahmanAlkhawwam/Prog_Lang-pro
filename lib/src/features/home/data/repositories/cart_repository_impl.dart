import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../../product/data/models/product_model.dart';
import '../../../product/domain/entities/product.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data_source/cart_local_data_source.dart';

class CartRepositoryImpl extends CartRepository {
  final CartLocalDataSource dataSource;

  CartRepositoryImpl({required this.dataSource});

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
}
