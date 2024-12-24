import 'dart:io';

import '../../../home/domain/entities/Location.dart';

class User {
  final int id;
  final int phone;
  final String firstName;
  final String lastName;
  final Location? location;
  final String? imagePath;
  final File? imageFile;
  final String? token;

  User({
    required this.id,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.token,
    required this.imagePath,
    this.imageFile,
    this.location,
  });

  User copyWith(
      {int? id,
      int? phone,
      String? firstName,
      String? lastName,
      Location? location,
      String? imagePath,
      File? imageFile}) {
    return User(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      location: location ?? this.location,
      imagePath: imagePath ?? this.imagePath,
      imageFile: imageFile ?? this.imageFile,
      token: token,
    );
  }
}
