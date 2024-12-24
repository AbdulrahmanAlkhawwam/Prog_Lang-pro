import '../../../shop/domain/entities/shop.dart';

class Product {
  final String id;
  final String name;
  final String description;

  final List<String> ingredients;
  final double price;

  final Shop? market;

  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.price,
    required this.market,
    required this.quantity,
  });
}
