part of 'test_bloc.dart';

enum TestStatus {init , error, success, loading }

@immutable
class TestState {
  TestStatus status;
  List<Product>? products;
  String? message;

  TestState({
    this.status =TestStatus.init,
    this.message,
    this.products,
  });

  TestState copyWith({
    TestStatus? status,
    String? message,
    List<Product>? products,
  }) {
    return TestState(
      message: message ?? this.message,
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }
}
