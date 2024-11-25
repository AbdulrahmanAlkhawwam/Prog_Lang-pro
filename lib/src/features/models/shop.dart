import './Location.dart';
import './category.dart';

class Shop {
  /// unique id (not repeat)
  final String id;

  /// name for shop 8 - 12 character not more
  final String name;

  /// description for shop 8 - 32 character not more
  final String? description;

  final Location place;

  /// status [Opened],[Closed]
  final String status;

  final Category category;

  Shop({
    required this.id,
    required this.name,
    this.description,
    required this.place,
    required this.status,
    required this.category,
  });
}
