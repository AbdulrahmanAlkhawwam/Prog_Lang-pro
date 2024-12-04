import 'package:program_language_project/src/features/models/Location.dart';

class User {
  final int id;
  final int phone;
  final String? imageUrl;
  final Location? location;
  final String firstName;
  final String token;
  final String lastName;

  User({
    required this.id,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.token,
    this.location,
    this.imageUrl,
  });
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
        id: json["User"]["id"],
        firstName: json["User"]["firstname"],
        lastName: json["User"]["lastname"],
        phone: json["User"]["phone"],
        imageUrl: json["User"]["profileImage"],
        location: json["User"]["latitude"] == null
            ? null
            : Location(
                latitudes: json["User"]["latitude"],
                longitudes: json["User"]["longitude"],
              ),
        token: json["Token"],
      );
}
