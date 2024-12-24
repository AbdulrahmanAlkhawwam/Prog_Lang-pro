part of 'shop_bloc.dart';

@immutable
abstract class ShopEvent {}

final class GetShops extends ShopEvent {}

final class GetShopsDetails extends ShopEvent {
  final int id;

  GetShopsDetails({required this.id});
}
