import 'package:program_language_project/src/features/product/data/models/product_model.dart';

import '../../../../core/helpers/http_helper.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<ProductModel>> getFavorites();

  Future<bool> getFavorite(int id);

  Future<void> setFavorite(int id);

  Future<void> deleteFavorite(int id);
}

class FavoriteRemoteDataSourceImpl extends FavoriteRemoteDataSource {
  final HttpHelper http;

  FavoriteRemoteDataSourceImpl({required this.http});

  @override
  Future<List<ProductModel>> getFavorites() async {
    final response = await http.handleApiCall(
      () async => await http.get("/favorite"),
    ) as List<dynamic>;
    return response.map((e) => ProductModel.fromMap(e, false)).toList();
  }

  @override
  Future<bool> getFavorite(int id) async {
    final response = await http
        .handleApiCall(() async => await http.get("/favorite/isFavorite/$id"));
    return response["isFavorite"];
  }

  @override
  Future<void> deleteFavorite(int id) async {
    await http.handleApiCall(() async => await http.delete("/favorite/$id"));
  }

  @override
  Future<void> setFavorite(int id) async {
    await http.handleApiCall(() async => await http.post("/favorite/$id"));
  }
}
