import '../../../product/domain/entities/product.dart';

class Order {
  final int id;
  final String status;
  final double price;
  final List<Product> products;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.status,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    this.products = const [],
  });
}
