part of 'shop_bloc.dart';

enum ShopStatus { init, error, success, loading }

class ShopState {
  ShopStatus status;
  List<Shop> shops;
  List<Category> categories;
  Shop? shop;

  Message? message;

  ShopState({
    this.status = ShopStatus.init,
    this.message,
    this.shops = const [],
    this.categories = const [],
    this.shop,
  });

  ShopState copyWith({
    ShopStatus? status,
    Message? message,
    List<Shop>? shops,
    List<Category>? categories,
    Shop? shop,
  }) {
    return ShopState(
      message: message ?? this.message,
      status: status ?? this.status,
      shops: shops ?? this.shops,
      categories: categories ?? this.categories,
      shop: shop ?? this.shop,
    );
  }
}
