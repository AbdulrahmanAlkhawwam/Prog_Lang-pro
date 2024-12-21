part of 'shop_bloc.dart';

enum ShopsStatus { init, error, success, loading }

class ShopState {
  ShopsStatus status;
  List<Shop>? shops;
  Message? message;

  ShopState({
    this.status = ShopsStatus.init,
    this.message,
    this.shops,
  });

  ShopState copyWith({
    ShopsStatus? status,
    Message? message,
    List<Shop>? shops,
  }) {
    return ShopState(
      message: message ?? this.message,
      status: status ?? this.status,
      shops: shops ?? this.shops,
    );
  }
}
