import '../../../product/domain/entities/product.dart';

class Purchase {
  final int id;
  final String name;
  final int storeId;
  final double price;
  final List<Product> products;

  Purchase({
    required this.id,
    required this.name,
    required this.storeId,
    required this.price,
    this.products = const [],
  });
}
