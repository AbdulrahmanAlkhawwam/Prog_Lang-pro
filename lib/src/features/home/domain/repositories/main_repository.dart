import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../shop/domain/entities/shop.dart';

abstract class MainRepository {
  Future<Either<Failure, List<Shop>>> search(String searchText);

  String image(String path);
}
