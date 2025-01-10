part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;

  AddToCart({required this.product});
}

class CreateOrder extends CartEvent {}

class GetCart extends CartEvent {}
