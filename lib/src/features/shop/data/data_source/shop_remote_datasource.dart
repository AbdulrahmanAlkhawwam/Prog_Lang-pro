import '../../../../core/helpers/http_helper.dart';
import '../models/shop_model.dart';

abstract class ShopRemoteDatasource {
  Future<List<ShopModel>> getShops();

  Future<ShopModel> getShop(int id);
}

class ShopRemoteDatasourceImpl extends ShopRemoteDatasource {
  final HttpHelper http;

  ShopRemoteDatasourceImpl({required this.http});

  @override
  Future<List<ShopModel>> getShops() async {
    final response = await http.handleApiCall(
      () async => http.get('/store'),
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
}
