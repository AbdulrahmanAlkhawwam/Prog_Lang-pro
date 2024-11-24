abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() {
    return "$runtimeType($message)";
  }
}

/// local failure
class DatabaseFailure extends Failure {
  DatabaseFailure(super.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

/// remote failure
class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class ServerFailure extends Failure {
  final int? statusCode;

  ServerFailure(super.message, {this.statusCode});

  List<Object?> get props => [message, statusCode];
}

class AuthorizationFailure extends Failure {
  AuthorizationFailure(super.message);
}

/// failures
class UnknownFailure extends Failure {
  UnknownFailure(super.message);
}

class ParsingFailure extends Failure {
  ParsingFailure(super.message);
}