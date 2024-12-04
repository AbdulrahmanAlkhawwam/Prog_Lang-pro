import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/product.dart';
import '../repositories/products/product_repository.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductState()) {
    on<ProductEvent>(_getProducts);
  }

  FutureOr<void> _getProducts(ProductEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    final response = await repository.call();
    response.fold(
      (failure) => emit(state.copyWith(status: ProductStatus.error)),
      (products) => emit(
        state.copyWith(
          status: ProductStatus.success,
          products: products,
        ),
      ),
    );
  }
}
