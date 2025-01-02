import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/message.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repository;

  OrderBloc({required this.repository}) : super(OrderState()) {
    on<GetOrders>(_getOrders);
  }

  FutureOr<void> _getOrders(GetOrders event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.loading));
    final response = await repository.getOrders();

    response.fold(
      (failure) => emit(state.copyWith(
        status: OrderStatus.error,
        message: Message.fromFailure(failure),
      )),
      (orders) => emit(state.copyWith(
        status: OrderStatus.success,
        completedOrders: orders.where((e) => e.status == "COMPLETED").toList(),
        inCompletedOrders: orders.where((e) => e.status == "PENDING").toList(),
        canceledOrders: orders.where((e) => e.status == "CANCELED").toList(),
      )),
    );
  }
}
