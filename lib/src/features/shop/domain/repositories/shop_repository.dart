import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/features/shop/domain/entities/category.dart';

import '../../../../core/errors/failures.dart';
import '../entities/shop.dart';

abstract class ShopRepository {
  Future<Either<Failure, List<Shop>>> getShops(int? typeId);

  Future<Either<Failure, Shop>> getShop(int id);

  Future<Either<Failure, List<Category>>> getShopCategories(int shopId);

  Future<Either<Failure, List<Category>>> getCategories ();
}

