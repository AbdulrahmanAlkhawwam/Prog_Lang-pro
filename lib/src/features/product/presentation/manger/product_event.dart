part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

final class GetShopProduct extends ProductEvent {
  final int shopId;

  GetShopProduct({required this.shopId});
}

final class GetProductsCategories extends ProductEvent {}
