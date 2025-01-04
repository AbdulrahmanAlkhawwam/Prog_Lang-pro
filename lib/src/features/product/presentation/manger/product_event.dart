part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

final class GetShopProducts extends ProductEvent {
  final int shopId;

  GetShopProducts({required this.shopId});
}

final class GetProductsCategories extends ProductEvent {}
