part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class GetOrders extends OrderEvent {}

class CancelledOrder extends OrderEvent {
  final int id ;
  CancelledOrder({required this.id});
}