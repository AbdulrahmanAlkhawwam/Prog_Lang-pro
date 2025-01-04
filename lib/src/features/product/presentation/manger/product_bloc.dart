import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/message.dart';
import '../../../shop/domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductState()) {
    // on<ProductEvent>(_getProducts);
    on<GetShopProducts>(_getShopProducts);
    on<GetProductsCategories>(_getCategories);
  }

  // FutureOr<void> _getProducts(
  //     ProductEvent event, Emitter<ProductState> emit) async {
  //   emit(state.copyWith(status: ProductStatus.loading));
  //   final response = await repository.getProducts();
  //   response.fold(
  //     (failure) => emit(state.copyWith(status: ProductStatus.error)),
  //     (products) => emit(
  //       state.copyWith(
  //         status: ProductStatus.success,
  //         products: products,
  //       ),
  //     ),
  //   );
  // }

  FutureOr<void> _getShopProducts(
      GetShopProducts event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    final response = await repository.getShopProducts(event.shopId);
    response.fold(
      (failure) => emit(state.copyWith(
        status: ProductStatus.error,
        message: Message.fromFailure(failure),
      )),
      (products) => emit(state.copyWith(products: products)),
    );
  }

  FutureOr<void> _getCategories(
      GetProductsCategories event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    final response = await repository.getCategories();

    response.fold(
            (failure) => emit(state.copyWith(
          status: ProductStatus.error,
          message: Message.fromFailure(failure),
        )),
            (categories) => emit(state.copyWith(
          status: ProductStatus.success,
          categories: categories,
        )));
  }
}
