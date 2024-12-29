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

  final List<Order> orders;

  const OrderState({
    this.status = OrderStatus.init,
    this.message,
    this.orders = const [],
  });

  OrderState copyWith({
    OrderStatus? status,
    Message? message,
    List<Order>? orders,
  }) {
    return OrderState(
      message: message ?? this.message,
      status: status ?? this.status,
      orders: orders ?? this.orders,
    );
  }
}
