class Shop {
  final int id;
  final String name;
  final String description;
  final String status;
  final String imagePath;
  final String address;

  Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.status,
    required this.address,
  });

  @override
  String toString() {
    return "shop {"
        " id : $id ,"
        " name : $name ,"
        " description : $description ,"
        " image path : $imagePath ,"
        " status : $status ,"
        " address : $address ,"
        "}";
  }
}
