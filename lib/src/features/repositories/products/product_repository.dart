import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../datasources/products/products_remote_datasource.dart';
import '../../models/product.dart';

class ProductRepository {
  final ProductsRemoteDatasource datasource ;

  ProductRepository({required this.datasource});

  Future<Either<Failure,List<Product>>> call () async{
    try{
      return Right(await datasource.getProducts());
    }catch(e){
      return Left(UnknownFailure(e.toString()));
    }
  }
}