import 'package:program_language_project/src/features/product/data/models/product_model.dart';

import '../../../../core/helpers/http_helper.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<ProductModel>> getFavorites();
}

class FavoriteRemoteDataSourceImpl extends FavoriteRemoteDataSource {
  final HttpHelper http;

  FavoriteRemoteDataSourceImpl({required this.http});

  @override
  Future<List<ProductModel>> getFavorites() async {
    final response = await http.handleApiCall(
      () async => await http.get("/favorite"),
    ) as List<dynamic>;
    return response.map((e) => ProductModel.fromMap(e)).toList();
  }
}
