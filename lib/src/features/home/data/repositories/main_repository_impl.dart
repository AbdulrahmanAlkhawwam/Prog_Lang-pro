import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/features/product/domain/entities/product.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/app_util.dart';
import '../../domain/repositories/main_repository.dart';
import '../data_source/main_remote_datasource.dart';
import '../../../shop/domain/entities/shop.dart';

class MainRepositoryImpl extends MainRepository {
  final MainRemoteDatasource datasource;

  MainRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<Shop>>> searchStore(String searchText) async =>
      await AppUtils.safeCall(
          () async => await datasource.searchStore(searchText));

  @override
  String image(String path) => datasource.image(path);

  @override
  Future<Either<Failure, List<Product>>> searchProduct(
          String searchText) async =>
      await AppUtils.safeCall(
          () async => await datasource.searchProduct(searchText));
}
