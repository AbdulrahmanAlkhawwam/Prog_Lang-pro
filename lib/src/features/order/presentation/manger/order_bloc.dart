import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:program_language_project/src/features/order/domain/use_cases/cancelled_order_uc.dart';
import 'package:program_language_project/src/features/order/domain/use_cases/get_orders_uc.dart';

import '../../../../core/utils/message.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrdersUc getOrdersUc;
  final CancelledOrderUC cancelledOrderUC;

  OrderBloc({
    required this.getOrdersUc,
    required this.cancelledOrderUC,
  }) : super(OrderState()) {
    on<GetOrders>(_getOrders);
    on<CancelledOrder>(_cancelledOrder);
  }

  FutureOr<void> _getOrders(GetOrders event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.loading));
    final response = await getOrdersUc();

    response.fold(
      (failure) => emit(state.copyWith(
        status: OrderStatus.error,
        message: Message.fromFailure(failure),
      )),
      (orders) => emit(state.copyWith(
        status: OrderStatus.success,
        completedOrders: orders.where((e) => e.status == "COMPLETED").toList(),
        inCompletedOrders: orders.where((e) => e.status == "PENDING").toList(),
        canceledOrders: orders.where((e) => e.status == "CANCELLED").toList(),
      )),
    );
  }

  FutureOr<void> _cancelledOrder(
      CancelledOrder event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.loading));
    final response = await cancelledOrderUC(param: event.id);

    response.fold(
      (failure) => emit(state.copyWith(
        status: OrderStatus.error,
        message: Message.fromFailure(failure),
      )),
      (_) => add(GetOrders()),
    );
  }
}
