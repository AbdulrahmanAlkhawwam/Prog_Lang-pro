import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/utils/app_util.dart';
import '../../datasources/shops/shops_remote_datasorce.dart';
import '../../models/shop.dart';

class ShopsRepository {
  final ShopsRemoteDatasorce datasource;

  ShopsRepository({required this.datasource});

  Future<Either<Failure, List<Shop>>> call() async {
    return await AppUtils.safeCall(() async => await datasource.GetShops());
  }
}
