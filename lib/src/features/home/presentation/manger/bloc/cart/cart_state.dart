part of 'cart_bloc.dart';

enum CartStatus {
  init,
  error,
  loading,
  success,
}

@immutable
class CartState {
  final CartStatus status;
  final Message? message;
  final List<Product>? cart;

  const CartState(
      {this.status = CartStatus.init, this.message, this.cart = const []});

  CartState copyWith({
    CartStatus? status,
    Message? message,
    List<Product>? cart,
  }) =>
      CartState(
        status: status ?? this.status,
        message: message ?? this.message,
        cart: cart ?? this.cart,
      );
}
