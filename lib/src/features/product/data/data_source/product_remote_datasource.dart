import '../../../../core/helpers/http_helper.dart';
import '../../../shop/data/models/category_model.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDatasource {
  // Future<List<ProductModel>> getProducts();

  Future<List<ProductModel>> getShopProducts(int shopId);

  Future<List<CategoryModel>> getCategories();
}

class ProductRemoteDatasourceImpl extends ProductRemoteDatasource {
  final HttpHelper http;

  ProductRemoteDatasourceImpl({required this.http});

  // @override
  // Future<List<ProductModel>> getProducts() async {
  //   final response = http.handleApiCall(
  //     () => http.get('/Product'),
  //   );
  //   final data = response as List<dynamic>;
  //   return data.map((e) => ProductModel.fromMap(e)).toList();
  // }

  @override
  Future<List<ProductModel>> getShopProducts(int shopId) async {
    final response =
        http.handleApiCall(() async => await http.get("/product/$shopId/store"))
            as List<dynamic>;
    return response.map((e) => ProductModel.fromMap(e)).toList();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await http.handleApiCall(
        () async => await http.get("/category") as List<dynamic>);

    return response.map((e) => CategoryModel.fromMap(e)).toList();
  }
}
