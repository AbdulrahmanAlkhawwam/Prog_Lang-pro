import 'package:program_language_project/src/features/models/Location.dart';

class User {
  final int id;
  final int phone;
  final String? imageUrl;
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
        id: json["user"]?["id"] ,
        firstName: json["user"]?["first_name"],
        lastName: json["user"]?["last_name"] ,
        phone: json["user"]?["phone"] ,
        imageUrl: json["user"]?["profile_image"],
        location: json["user"]?["latitude"] == null
            ? null
            : Location(
                latitudes: json["user"]?["latitude"],
                longitudes: json["user"]?["longitude"],
              ),
        token: json["token"],
      );


}
