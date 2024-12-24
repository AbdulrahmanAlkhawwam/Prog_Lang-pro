import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/shop.dart';

abstract class ShopRepository {
  Future<Either<Failure, List<Shop>>> getShops();

  Future<Either<Failure, Shop>> getShop(int id);
}

