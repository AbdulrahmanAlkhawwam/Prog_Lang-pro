import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../domain/repositories/main_repository.dart';
import '../data_source/main_remote_datasource.dart';
import '../../../shop/domain/entities/shop.dart';

class MainRepositoryImpl extends MainRepository {
  final MainRemoteDatasource datasource;

  MainRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<Shop>>> search(String searchText) async {
    return await AppUtils.safeCall(
        () async => await datasource.search(searchText));
  }

  @override
  String image(String path) => datasource.image(path);
}
