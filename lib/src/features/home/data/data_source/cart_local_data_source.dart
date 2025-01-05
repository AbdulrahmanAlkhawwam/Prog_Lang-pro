import 'package:program_language_project/src/core/constants/strings.dart';
import 'package:program_language_project/src/core/helpers/database_helper.dart';

import '../../../product/data/models/product_model.dart';

abstract class CartLocalDataSource {
  Future<void> addToCart(ProductModel product);

  Future<List<ProductModel>> getCart();
}

class CartLocalDataSourceImpl extends CartLocalDataSource {
  final DatabaseHelper database;

  CartLocalDataSourceImpl({required this.database});

  @override
  Future<void> addToCart(ProductModel product) async {
    print(product);
    await database.insert(cartTable, product.toJson());
    final data = await database.getData(cartTable);
    print("000000000 ${data.toList().toString()}");
  }

  @override
  Future<List<ProductModel>> getCart() async {
    final data = await database.getData(cartTable) as List<dynamic>?;
    print("000000000 ${data.toString()}");
    return data?.map((e) => ProductModel.fromMap(e)).toList() ?? [];
  }
}
