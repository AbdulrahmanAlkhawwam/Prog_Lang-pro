import '../../../home/domain/entities/Location.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.phone,
    required super.token,
    super.location,
    super.imagePath,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["user"]?["id"],
        firstName: json["user"]?["first_name"],
        lastName: json["user"]?["last_name"],
        phone: json["user"]?["phone"],
        imagePath: json["user"]?["image"],

        location: json["user"]?["latitude"] == null
            ? null
            : Location(
                latitudes: json["user"]?["latitude"],
                longitudes: json["user"]?["longitude"],
              ),
        token: json["token"],
      );
}
