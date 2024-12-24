import '../../domain/entities/product.dart';

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
      market:
          null /*Shop(
        id: json["market"]["id"],
        name: json["market"]["name"],
        place: json["market"]["place"],
        status: json["market"]["status"],
        category: Category(
          id: json["market"]["category"]["id"],
          iconId: json["market"]["category"]["iconId"],
          categoryName: json["market"]["category"]["name"],
        ),
      ),*/
      ,
      quantity: json["quantity"]);
}
