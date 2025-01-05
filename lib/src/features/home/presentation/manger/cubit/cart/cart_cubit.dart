import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:program_language_project/src/core/utils/message.dart';
import 'package:program_language_project/src/features/home/data/repositories/cart_repository_impl.dart';
import 'package:program_language_project/src/features/product/domain/entities/product.dart';

import '../../../../domain/repositories/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository repository;

  CartCubit({required this.repository}) : super(CartState());

  FutureOr<void> addToCart(Product product) async {
    if (isClosed) return;
    emit(state.copyWith(status: CartStatus.loading));
    final response = await repository.addToCart(product);
    response.fold(
      (failure) => emit(state.copyWith(
        status: CartStatus.error,
        message: Message.fromFailure(failure),
      )),
      (_) => emit(state.copyWith(status: CartStatus.success)),
    );
  }

  FutureOr<void> getCart() async {
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
}
