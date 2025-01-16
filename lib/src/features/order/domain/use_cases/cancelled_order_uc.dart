import 'package:dartz/dartz.dart';
import 'package:program_language_project/src/core/errors/failures.dart';
import 'package:program_language_project/src/core/use_case/use_case.dart';
import 'package:program_language_project/src/features/order/domain/repositories/order_repository.dart';

class CancelledOrderUC extends UseCase<void, int> {
  final OrderRepository repository;

  CancelledOrderUC({required this.repository});

  @override
  Future<Either<Failure, void>> call({required int param}) async =>
      repository.cancelledOrder(param);
}
