import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/utils/app_util.dart';
import '../../datasources/shops/shop_remote_datasource.dart';
import '../../models/shop.dart';

class ShopRepository {
  final ShopRemoteDatasource datasource;

  ShopRepository({required this.datasource});

  Future<Either<Failure, List<Shop>>> call() async {
    return await AppUtils.safeCall(() async => await datasource.getShops());
  }
}
