import '../../../../core/helpers/http_helper.dart';
import '../models/category_model.dart';
import '../models/shop_model.dart';

abstract class ShopRemoteDatasource {
  Future<List<ShopModel>> getShops(int? typeId);

  Future<ShopModel> getShop(int id);

  Future<List<CategoryModel>> getShopCategories(int shopId);

  Future<List<CategoryModel>> getCategories();
}

class ShopRemoteDatasourceImpl extends ShopRemoteDatasource {
  final HttpHelper http;

  ShopRemoteDatasourceImpl({required this.http});

  @override
  Future<List<ShopModel>> getShops(int? typeId) async {
    final response = await http.handleApiCall(
      () async => http.get(typeId == null ? "/store" : "/store/$typeId/type"),
    ) as List<dynamic>;
    return response.map((e) => ShopModel.fromJson(e)).toList();
  }

  @override
  Future<ShopModel> getShop(int id) async {
    final response = await http.handleApiCall(
      () async => await http.get("/store/$id"),
    ) as Map<String, dynamic>;
    return ShopModel.fromJson(response);
  }

  @override
  Future<List<CategoryModel>> getShopCategories(int shopId) async {
    final response = await http.handleApiCall(
      () async => await http.get("/store/$shopId/type"),
    ) as List<dynamic>;
    // TODO : don't forget to fix this api output
    return response.map((e) => CategoryModel.fromMap(e)).toList();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await http
        .handleApiCall(() async => await http.get("/type") as List<dynamic>);

    return response.map((e) => CategoryModel.fromMap(e)).toList();
  }
}
