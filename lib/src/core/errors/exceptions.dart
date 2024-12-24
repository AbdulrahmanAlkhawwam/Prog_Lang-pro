abstract class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => "$runtimeType($message)";
}

class DeleteException extends AppException {
  DeleteException(super.message);

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;

  const CacheException(this.message);

  @override
  String toString() {
    return "$runtimeType($message)";
  }
}

class ServerException extends AppException {
  final int? statusCode;
  final body;

  ServerException(super.message, {this.statusCode, this.body});

  @override
  String toString() => "$runtimeType[$statusCode]($message)";
}

class AuthorizationException extends AppException {
  final bool retry;

  AuthorizationException(super.message, this.retry);
}

class ParsingException extends AppException {
  ParsingException(super.message);
}
