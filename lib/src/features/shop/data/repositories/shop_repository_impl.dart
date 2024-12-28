import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/features/shop/domain/entities/category.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../domain/entities/shop.dart';
import '../../domain/repositories/Shop_repository.dart';
import '../data_source/shop_remote_datasource.dart';

class ShopRepositoryImpl extends ShopRepository {
  final ShopRemoteDatasource datasource;

  ShopRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<Shop>>> getShops(int? typeId) async {
    return await AppUtils.safeCall(() async => await datasource.getShops(typeId));
  }

  @override
  Future<Either<Failure, Shop>> getShop(int id) async {
    return await AppUtils.safeCall(() async => await datasource.getShop(id));
  }

  @override
  Future<Either<Failure, List<Category>>> getShopCategories(int shopId) async {
    return await AppUtils.safeCall(
        () async => await datasource.getShopCategories(shopId));
  }
}
