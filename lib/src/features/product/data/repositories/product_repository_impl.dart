import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_source/product_remote_datasource.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDatasource datasource;

  ProductRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    return AppUtils.safeCall(() async => await await datasource.getProducts());
  }
}
