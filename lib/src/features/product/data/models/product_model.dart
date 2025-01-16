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

  factory ProductModel.fromMap(Map<String, dynamic> json, bool isOrder) =>
      ProductModel(
        id: json["id"],
        storeId: json["store_Id"],
        categoryId: json["category_Id"],
        price: double.parse(json["price"]),
        name: json["product_name"],
        description: json["description"],
        quantity: isOrder ? json["pivot"]["quantity"] : json["quantity"],
        image: json["image"],
      );

  factory ProductModel.fromEntity(Product product) => ProductModel(
        id: product.id,
        storeId: product.storeId,
        categoryId: product.categoryId,
        name: product.name,
        description: product.description,
        image: product.image,
        price: product.price,
        quantity: product.quantity,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_Id": storeId,
        "category_Id": categoryId,
        "quantity": 1,
        "image": image,
        "price": price.toString(),
        "product_name": name,
      };
}
