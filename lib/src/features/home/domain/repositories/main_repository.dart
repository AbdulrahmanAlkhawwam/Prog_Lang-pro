import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/features/product/domain/entities/product.dart';

import '../../../../core/errors/failures.dart';
import '../../../shop/domain/entities/shop.dart';

abstract class MainRepository {
  Future<Either<Failure, List<Shop>>> searchStore(String searchText);

  Future<Either<Failure, List<Product>>> searchProduct (String searchText);

  String image(String path);
}
