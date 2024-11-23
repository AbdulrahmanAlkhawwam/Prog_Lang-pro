abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => "$runtimeType($message)";
}

class DatabaseFailure extends Failure {
  DatabaseFailure(super.message);
}
