import 'package:program_language_project/src/core/constants/strings.dart';
import 'package:program_language_project/src/core/helpers/database_helper.dart';

import '../../../product/data/models/product_model.dart';

abstract class CartLocalDataSource {
  Future<void> addToCart(ProductModel product);

  Future<List<ProductModel>> getCart();

  Future<void> emptyCart();

  Future<void> deleteProduct(int id, bool allAmount);
}

class CartLocalDataSourceImpl extends CartLocalDataSource {
  final DatabaseHelper database;

  CartLocalDataSourceImpl({required this.database});

  @override
  Future<void> addToCart(ProductModel product) async {
    var data =
        await database.getData(cartTable, where: "id = ? ", args: [product.id]);
    if (data.isEmpty) {
      await database.insert(cartTable, product.toJson());
    } else {
      await database.update(cartTable, {
        "id": product.id,
        "quantity": ProductModel.fromMap(data.first, false).quantity + 1,
      });
    }
  }

  @override
  Future<List<ProductModel>> getCart() async {
    final data = await database.getData(cartTable) as List<dynamic>?;
    // todo : fix this
    print("000000000 ${data.toString()}");
    return data?.map((e) => ProductModel.fromMap(e, false)).toList() ?? [];
  }

  @override
  Future<void> emptyCart() async {
    await database.delete(cartTable);
    final data = await database.getData(cartTable);
    print("0000 ${data.toList().toString()}");
  }

  @override
  Future<void> deleteProduct(int id, bool allAmount) async {
    var data = await database.getData(cartTable, where: "id = ? ", args: [id]);
    if (allAmount || data.first["quantity"] == 1) {
      database.delete(cartTable, where: "id = ?", args: [id]);
    } else {
      await database.update(cartTable, {
        "id": id,
        "quantity": ProductModel.fromMap(data.first, false).quantity - 1,
      });
    }
  }
}
