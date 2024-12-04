import 'package:program_language_project/src/features/models/category.dart';

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

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.ingredients,
    required super.price,
    required super.market,
    required super.quantity,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      ingredients: [
        // TODO : fix this list
        "String",
        "String",
        "String",
      ],
      price: json["price"],
      market: Shop(
        id: json["market"]["id"],
        name: json["market"]["name"],
        place: json["market"]["place"],
        status: json["market"]["status"],
        category: Category(
          id: json["market"]["category"]["id"],
          iconId: json["market"]["category"]["iconId"],
          categoryName: json["market"]["category"]["name"],
        ),
      ),
      quantity: json["quantity"]);
}
