import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../domain/entities/shop.dart';
import '../../domain/repositories/Shop_repository.dart';
import '../data_source/shop_remote_datasource.dart';

class ShopRepositoryImpl extends ShopRepository {
  final ShopRemoteDatasource datasource;

  ShopRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<Shop>>> getShops() async {
    return await AppUtils.safeCall(() async => await datasource.getShops());
  }

  @override
  Future<Either<Failure, Shop>> getShop(int id) async {
    return await AppUtils.safeCall(() async => await datasource.getShop(id));
  }
}
