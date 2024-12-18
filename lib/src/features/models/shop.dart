import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import './Location.dart';
import './category.dart';

class Shop {
  final int id;
  final String name;
  final String description;
  final Location? place;
  final String status;
  final Category category;
  final String imageUrl;
  final String address;

  Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.place,
    required this.status,
    required this.category,
    required this.address,
  });
}

class ShopModel extends Shop {
  ShopModel({
    required super.id,
    required super.name,
    required super.place,
    required super.status,
    required super.category,
    required super.description,
    required super.imageUrl,
    required super.address,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
      id: json["User"]?["id"] ?? json["id"],
      name: json["storename"],
      description: json["descriptions"],
      imageUrl: json["imageURL"],
      place: json["User"]?["latitude"] == null
          ? null
          : Location(
              latitudes: json["User"]?["latitude"],
              longitudes: json["User"]?["longitude"],
            ),
      address: json["address"],
      status:"OPENED",
          // _getStatus(_getTime(json["timeopen"]), _getTime(json["timeClose"])),
      category: Category(
        id: "123",
        iconId: 123,
        categoryName: "categoryName",
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
