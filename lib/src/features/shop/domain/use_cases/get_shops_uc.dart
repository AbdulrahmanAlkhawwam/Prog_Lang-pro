import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/core/errors/failures.dart';
import 'package:program_language_project/src/core/use_case/use_case.dart';
import 'package:program_language_project/src/features/shop/domain/entities/shop.dart';
import 'package:program_language_project/src/features/shop/domain/repositories/Shop_repository.dart';

class GetShopsUC extends UseCase<List<Shop>, int?> {
  final ShopRepository repository ;

  GetShopsUC({required this.repository});

  @override
  Future<Either<Failure, List<Shop>>> call({required int? param}) async{
    return await repository.getShops(param);
  }


}
