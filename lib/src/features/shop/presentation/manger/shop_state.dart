part of 'shop_bloc.dart';

enum ShopStatus { init, error, success, loading }

class ShopState {
  ShopStatus status;
  List<Shop>? shops;
  Shop? shop;

  Message? message;

  ShopState({
    this.status = ShopStatus.init,
    this.message,
    this.shops,
    this.shop,
  });

  ShopState copyWith({
    ShopStatus? status,
    Message? message,
    List<Shop>? shops,
    Shop? shop,
  }) {
    return ShopState(
      message: message ?? this.message,
      status: status ?? this.status,
      shops: shops ?? this.shops,
      shop: shop ?? this.shop,
    );
  }
}
