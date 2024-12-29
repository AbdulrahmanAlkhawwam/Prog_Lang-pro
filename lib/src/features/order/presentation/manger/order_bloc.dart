import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:program_language_project/src/core/utils/message.dart';
import 'package:program_language_project/src/features/order/domain/entities/order.dart';
import 'package:program_language_project/src/features/order/domain/repositories/order_repository.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repository;

  OrderBloc({required this.repository}) : super(OrderState()) {
    on<GetOrders>(_getOrders);
  }

  FutureOr<void> _getOrders(GetOrders event, Emitter<OrderState> emit) async{
    emit(state);
  }
}
