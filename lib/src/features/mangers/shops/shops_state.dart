part of 'shops_bloc.dart';

enum ShopsStatus { init, error, success, loading }

class ShopsState {
   ShopsStatus status;
  List<Shop>? shops;
  Message? message;

  ShopsState({
    this.status = ShopsStatus.init,
    this.message,
    this.shops,
  });

  ShopsState copyWith({
    ShopsStatus? status,
    Message? message,
    // edit
    List<Shop>? shops,
  }) {
    return ShopsState(
      message: message ?? this.message,
      status: status ?? this.status,
      shops: shops ?? this.shops,
    );
  }
}
