part of 'shop_bloc.dart';

@immutable
abstract class ShopEvent {}

final class GetShops extends ShopEvent {
  final int? typeId;

  GetShops({this.typeId});
}

final class GetShopDetails extends ShopEvent {
  final int id;

  GetShopDetails({required this.id});
}

final class GetShopCategory extends ShopEvent {
  final int shopId;

  GetShopCategory({required this.shopId});
}
