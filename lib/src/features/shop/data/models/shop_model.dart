import 'package:flutter/material.dart';

import '../../../home/domain/entities/category.dart';
import '../../domain/entities/shop.dart';

class ShopModel extends Shop {
  ShopModel({
    required super.id,
    required super.name,
    required super.status,
    required super.category,
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
      status: "OPENED",
      // _getStatus(_getTime(json["timeopen"]), _getTime(json["timeClose"])),
      category: Category(
        id: 123,
        name: "categoryName",
      ));
}

TimeOfDay _getTime(String time) {
  return TimeOfDay(
    hour: int.parse(time.substring(0, time.indexOf(':') - 1)),
    minute: int.parse(time.substring(time.indexOf(':') + 1)),
  );
}

String _getStatus(TimeOfDay openTime, TimeOfDay closeTime) {
  return "OPENED";
}
