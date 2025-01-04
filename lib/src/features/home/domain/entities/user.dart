import 'dart:io';

import 'Location.dart';

class User {
  final int id;
  final int phone;
  final bool isVerified;
  final String firstName;
  final String lastName;
  final LocalLocation? location;
  final String? imagePath;
  final File? imageFile;
  final String? token;

  User({
    required this.id,
    required this.phone,
    required this.isVerified,
    required this.firstName,
    required this.lastName,
    required this.token,
    required this.imagePath,
    this.imageFile,
    this.location,
  });

  User copyWith({
    int? id,
    int? phone,
    String? firstName,
    String? lastName,
    LocalLocation? location,
    String? imagePath,
    bool? isVerified,
    File? imageFile,
  }) {
    return User(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      location: location ?? this.location,
      imagePath: imagePath ?? this.imagePath,
      imageFile: imageFile ?? this.imageFile,
      isVerified: isVerified ?? this.isVerified,
      token: token,
    );
  }
}
