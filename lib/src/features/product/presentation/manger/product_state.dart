part of 'product_bloc.dart';

enum ProductStatus { init, error, success, loading }

class ProductState {
  ProductStatus status;
  List<Product>? products;
  String? message;

  ProductState({
    this.status = ProductStatus.init,
    this.message,
    this.products,
  });

  ProductState copyWith({
    ProductStatus? status,
    String? message,
    List<Product>? products,
  }) {
    return ProductState(
      message: message ?? this.message,
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }
}
