import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/product.dart';
import '../repositories/products/product_repository.dart';

part 'test_event.dart';

part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final ProductRepository repository;

  TestBloc({required this.repository}) : super(TestState()) {
    on<TestEvent>(_getProducts);
  }

  FutureOr<void> _getProducts(TestEvent event, Emitter<TestState> emit) async {
    emit(state.copyWith(status: TestStatus.loading));
    final response = await repository.call();
    response.fold(
      (failure) => emit(state.copyWith(status: TestStatus.error)),
      (products) => emit(
        state.copyWith(
          status: TestStatus.success,
          products: products,
        ),
      ),
    );
  }
}
