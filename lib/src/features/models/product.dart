import './shop.dart';

class Product {
  /// unique id (not repeat)
  final String id;

  /// name for product 8 - 12 character not more
  final String name;

  /// description for product 8 - 32 character not more
  final String description;

  final List<String> ingredients;
  final double price;

  final Shop market;

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
