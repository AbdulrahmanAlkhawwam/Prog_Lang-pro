import 'dart:io';import "package:program_language_project/src/features/models/Location.dart";

class User {
  final int id;
  final int phone;
  late File? imageUrl;
  final Location? location;
  final String firstName;
  final String lastName;
  final String? token;

  User({
    required this.id,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.token,
    this.location,
    this.imageUrl,
  });
  User copyWith({File? imageUrl}) {
    return User(
      id: this.id,
      phone: this.phone,
      firstName: this.firstName,
      lastName: this.lastName,
      token: this.token,
      location: this.location,
      imageUrl: imageUrl ?? this.imageUrl
    );
  }
}



class UserModel extends User {
  UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.phone,
    required super.token,
    super.location,
    super.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["User"]?["id"] ?? json["id"],
        firstName: json["User"]?["firstname"] ?? json["firstname"],
        lastName: json["User"]?["lastname"] ?? json["lastname"],
        phone: json["User"]?["phone"] ?? json["phone"],
        imageUrl: json["User"]?["profileImage"] ?? json["profileImage"],
        location: json["User"]?["latitude"] == null
            ? null
            : Location(
                latitudes: json["User"]?["latitude"],
                longitudes: json["User"]?["longitude"],
              ),
        token: json["Token"],
      );
}
