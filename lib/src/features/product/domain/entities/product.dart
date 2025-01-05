class Product {
  final int id;
  final int storeId;
  final int categoryId;
  final String name;
  final String description;
  final String image;
  final double price;
  final int quantity;

  Product({
    required this.id,
    required this.storeId,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.quantity,
  });

  @override
  String toString() {
    return "product{"
        " id : $id ,"
        " storeId : $storeId ,"
        " categoryId : $categoryId ,"
        " name : $name ,"
        " description : $description ,"
        " image : $image ,"
        " price : $price ,"
        " quantity : $quantity }";
  }
}
