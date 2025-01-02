import '../../domain/entities/shop.dart';

class ShopModel extends Shop {
  ShopModel({
    required super.id,
    required super.name,
    required super.status,
    required super.description,
    required super.imagePath,
    required super.address,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        id: json["User"]?["id"] ?? json["id"],
        name: json["store_name"],
        description: json["descriptions"],
        imagePath: json["image"],
        address: json["address"],
        // TODO : don't forget to fix this
        status: json["status"] ?? "OPEN",
      );
}
