import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.storeId,
    required super.categoryId,
    required super.name,
    required super.description,
    required super.image,
    required super.price,
    required super.quantity,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        storeId: json["store_Id"],
        categoryId: json["category_Id"],
        price: double.parse(json["price"]),
        name: json["product_name"],
        description: json["description"],
        quantity: json["quantity"],
        image: json["image"],
      );
}
