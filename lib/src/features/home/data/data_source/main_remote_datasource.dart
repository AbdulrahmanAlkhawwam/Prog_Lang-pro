import '../../../../core/helpers/http_helper.dart';
import '../../../shop/data/models/shop_model.dart';
import '../../../shop/domain/entities/shop.dart';

abstract class MainRemoteDatasource {
  Future<List<Shop>> search(String searchText);

  String image(String path);
}

class MainRemoteDatasourceImpl extends MainRemoteDatasource {
  final HttpHelper http;

  MainRemoteDatasourceImpl({required this.http});

  @override
  Future<List<Shop>> search(String searchText) async {
    final response = await http.handleApiCall(() async =>
            await http.post("/search", body: {"store_name": searchText}))
        as List<dynamic>;
    return response.map((e) => ShopModel.fromJson(e)).toList();
  }

  @override
  String image(String path) {
    return http.makeUri("/$path").toString();
  }
}
