import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/core/errors/failures.dart';
import 'package:program_language_project/src/core/use_case/use_case.dart';
import 'package:program_language_project/src/features/home/domain/repositories/cart_repository.dart';

class DeleteProductUC extends UseCase<void, DeleteProductParam> {
  final CartRepository repository;

  DeleteProductUC({required this.repository});

  @override
  Future<Either<Failure, void>> call(
      {required DeleteProductParam param}) async {
    return await repository.deleteProduct(param.id, param.allAmount);
  }
}

class DeleteProductParam {
  final int id;

  final bool allAmount;

  DeleteProductParam({
    required this.id,
    required this.allAmount,
  });
}
