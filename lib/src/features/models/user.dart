import 'package:program_language_project/src/features/models/Location.dart';

class User {
  final String id;
  final String imageUrl;
  final Location location;
  final String firstName;
  final String lastName;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.location,
    required this.imageUrl,
  });
}
