import '../../domain/entities/Location.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.isVerified,
    required super.phone,
    required super.token,
    super.location,
    super.imagePath,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print(json["user"]?["latitude"]);
    return UserModel(
      id: json["user"]?["id"],
      firstName: json["user"]?["first_name"],
      lastName: json["user"]?["last_name"],
      phone: json["user"]?["phone"],
      imagePath: json["user"]?["image"],
      isVerified: json["user"]["is_verified"] == 1 ? true : false,
      location: json["user"]?["latitude"] == null
          ? null
          : LocalLocation(
              latitude: double.tryParse(json["user"]?["latitude"].toString()??''),
              longitude: double.tryParse(json["user"]?["longitude"].toString()??''),
            ),
      token: json["token"],
    );
  }
}
