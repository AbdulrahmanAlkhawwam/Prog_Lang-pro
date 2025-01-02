part of 'product_bloc.dart';

enum ProductStatus { init, error, success, loading }

class ProductState {
  ProductStatus status;
  List<Product> products;
  List<Category> categories;
  Message? message;

  ProductState({
    this.status = ProductStatus.init,
    this.message,
    this.products = const [],
    this.categories = const [],
  });

  ProductState copyWith({
    ProductStatus? status,
    Message? message,
    List<Product>? products,
    List<Category>? categories,
  }) {
    return ProductState(
      message: message ?? this.message,
      status: status ?? this.status,
      products: products ?? this.products,
      categories: categories ?? this.categories,
    );
  }
}
