part of 'order_bloc.dart';

enum OrderStatus {
  init,
  loading,
  error,
  success,
}

@immutable
class OrderState {
  final OrderStatus status;

  final Message? message;

  final List<Order> completedOrders;
  final List<Order> inCompletedOrders;
  final List<Order> canceledOrders;

  const OrderState({
    this.status = OrderStatus.init,
    this.message,
    this.completedOrders = const [],
    this.inCompletedOrders = const [],
    this.canceledOrders = const [],
  });

  OrderState copyWith({
    OrderStatus? status,
    Message? message,
    List<Order>? completedOrders,
    List<Order>? inCompletedOrders,
    List<Order>? canceledOrders,
  }) {
    return OrderState(
      message: message ?? this.message,
      status: status ?? this.status,
      completedOrders: completedOrders ?? this.completedOrders,
      inCompletedOrders: inCompletedOrders ?? this.inCompletedOrders,
      canceledOrders: canceledOrders ?? this.canceledOrders,
    );
  }
}
