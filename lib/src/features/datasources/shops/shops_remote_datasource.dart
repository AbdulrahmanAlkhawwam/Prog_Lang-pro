import '../../../core/helpers/http_helper.dart';
import '../../models/shop.dart';

abstract class ShopsRemoteDatasorce {
  Future<List<Shop>> GetShops();

  Future<ShopModel> getShop(int id);
}

class ShopsRemoteDatasourceImpl extends ShopsRemoteDatasorce {
  final HttpHelper http;

  ShopsRemoteDatasourceImpl({required this.http});

  @override
  Future<List<Shop>> GetShops() async {
    final response = await http.handleApiCall(
          () async => http.get('/stores'),
    ) as List<dynamic>;
    return response.map((e) => ShopModel.fromJson(e)).toList();
  }

  @override
  Future<ShopModel> getShop(int id)  async {
    final response  = await http.handleApiCall(() async => await http.get("/store/1"
    ));
    return ShopModel.fromJson(response);
  }
}
