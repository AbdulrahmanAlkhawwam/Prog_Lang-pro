import 'dart:developer' as dev;

import 'package:dartz/dartz.dart';

import '../errors/exceptions.dart';
import '../errors/failures.dart';

class AppUtils {
  AppUtils._();

  static Future<Either<Failure, T>> safeCall<T>(
    Future<T> Function() call,
  ) async {
    try {
      return Right(await call());
    } on ServerException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } on AuthorizationException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return Left(AuthorizationFailure(e.message));
    } on ParsingException catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return Left(ParsingFailure(e.message));
    } catch (e, s) {
      dev.log(e.runtimeType.toString(), error: e, stackTrace: s);
      return Left(UnknownFailure(e.toString()));
    }
  }
}
