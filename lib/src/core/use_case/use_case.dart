import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call({required Param param});
}

abstract class UseCaseNoParam<Type> {
  Future<Either<Failure, Type>> call();
}

abstract class UseCaseNoParamNoFuture<Type> {
  Either<Failure, Type> call();
}

abstract class UseCaseNoFuture<Type, Param> {
  Either<Failure, Type> call({required Param param});
}
