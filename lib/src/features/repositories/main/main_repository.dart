import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/utils/app_util.dart';
import '../../datasources/main/main_remote_datasource.dart';
import '../../models/shop.dart';

abstract class MainRepository {
  Future<Either<Failure, List<Shop>>> search(String searchText);
}

class MainRepositoryImpl extends MainRepository {
  final MainRemoteDatasource datasource;

  MainRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<Shop>>> search(String searchText) async {
    return await AppUtils.safeCall(
        () async => await datasource.search(searchText));
  }
}
