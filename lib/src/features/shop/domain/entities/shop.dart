
import '../../../home/domain/entities/category.dart';

class Shop {
  final int id;
  final String name;
  final String description;
  final String status;
  final Category category;
  final String imagePath;
  final String address;

  Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.status,
    required this.category,
    required this.address,
  });
}
