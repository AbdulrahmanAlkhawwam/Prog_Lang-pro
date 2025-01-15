import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:program_language_project/src/features/home/domain/repositories/cart_repository.dart';

import '../../../../../../core/utils/message.dart';
import '../../../../../product/domain/entities/product.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc({required this.repository}) : super(CartState()) {
    on<AddToCart>(_addToCart);
    on<GetCart>(_getCart);
    on<CreateOrder>(_createOrder);
  }

  FutureOr<void> _addToCart(AddToCart event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    final response = await repository.addToCart(event.product);
    response.fold(
      (failure) => emit(state.copyWith(
        status: CartStatus.error,
        message: Message.fromFailure(failure),
      )),
      (_) => emit(state.copyWith(status: CartStatus.success)),
    );
  }

  FutureOr<void> _getCart(GetCart event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    final response = await repository.getCart();
    response.fold(
        (failure) => emit(state.copyWith(
              status: CartStatus.error,
              message: Message.fromFailure(failure),
            )),
        (cart) => emit(state.copyWith(
              status: CartStatus.success,
              cart: cart,
            )));
  }

  FutureOr<void> _createOrder(
      CreateOrder event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    final response = await repository.createOrder();
    response.fold(
      (failure) => emit(state.copyWith(
        status: CartStatus.error,
        message: Message.fromFailure(failure),
      )),
      (_) => add(GetCart()),
    );
  }
}
