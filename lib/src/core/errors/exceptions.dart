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
