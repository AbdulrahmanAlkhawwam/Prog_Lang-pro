import '../../../core/helpers/http_helper.dart';
import '../../models/shop.dart';

abstract class ShopRemoteDatasource {
  Future<List<Shop>> getShops();
}

class ShopRemoteDatasourceImpl extends ShopRemoteDatasource {
  final HttpHelper http;

  ShopRemoteDatasourceImpl({required this.http});

  @override
  Future<List<Shop>> getShops() async {
    final response = await http.handleApiCall(
      () async => http.get('/stores'),
    ) as List<dynamic>;
    return response.map((e) => ShopModel.fromJson(e)).toList();
  }
}
