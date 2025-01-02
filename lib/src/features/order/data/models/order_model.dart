import '../../../product/data/models/product_model.dart';
import '../../domain/entities/order.dart';

class OrderModel extends Order {
  OrderModel({
    required super.id,
    required super.status,
    required super.price,
    required super.createdAt,
    required super.updatedAt,
    required super.products,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
      id: json["id"],
      price: double.parse(json["total_price"]),
      status: json["status"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      products: (json["products"] as List)
          .map((e) => ProductModel.fromMap(e))
          .toList());
}
