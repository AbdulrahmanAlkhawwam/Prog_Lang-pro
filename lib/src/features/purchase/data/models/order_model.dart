import '../../domain/entities/order.dart';

class OrderModel extends Order {
  OrderModel({
    required super.id,
    required super.name,
    required super.storeId,
    required super.price,
    super.products = const [],
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        name: json["name"],
        storeId: json["store_id"],
        price: json["price"],
      );
}
