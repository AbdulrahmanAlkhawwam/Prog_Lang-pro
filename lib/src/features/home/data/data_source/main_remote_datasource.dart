import 'package:program_language_project/src/features/product/data/models/product_model.dart';

import '../../../../core/helpers/http_helper.dart';
import '../../../shop/data/models/shop_model.dart';

abstract class MainRemoteDatasource {
  Future<List<ShopModel>> searchStore(String searchText);

  Future<List<ProductModel>> searchProduct(String searchText);

  String image(String path);
}

class MainRemoteDatasourceImpl extends MainRemoteDatasource {
  final HttpHelper http;

  MainRemoteDatasourceImpl({required this.http});

  @override
  Future<List<ShopModel>> searchStore(String searchText) async {
    final response = await http.handleApiCall(() async {
      return await http.post(
        "/store/search",
        body: {"store_name": searchText},
      );
    }) as List<dynamic>;
    return response.map((e) => ShopModel.fromJson(e)).toList();
  }

  @override
  String image(String path) {
    return http.makeUri("/$path").toString();
  }

  @override
  Future<List<ProductModel>> searchProduct(String searchText) async {
    final response = await http.handleApiCall(() async {
      return await http.post(
        "/product/search",
        body: {"product_name": searchText},
      );
    }) as List<dynamic>;
    return response.map((e) => ProductModel.fromMap(e,false)).toList();
  }
}
