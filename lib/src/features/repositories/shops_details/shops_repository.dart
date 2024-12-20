import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/features/datasources/shops/shops_remote_datasource.dart';

import '../../../core/errors/failures.dart';
import '../../../core/utils/app_util.dart';
import '../../models/shop.dart';

class ShopsDetailsRepository {
  final ShopsRemoteDatasorce datasource;

  ShopsDetailsRepository({required this.datasource});


   //edit
  Future<Either<Failure, List<Shop>>> call() async {
    // edit
    return await AppUtils.safeCall(() async => await datasource.GetShops());
  }
}
