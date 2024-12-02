import 'dart:convert';

import 'package:program_language_project/src/core/helpers/http_helper.dart';
import 'package:program_language_project/src/features/models/product.dart';

abstract class ProductsRemoteDatasource {
  Future<List<Product>> getProducts();
}

class ProductsRemoteDatasourceImpl extends ProductsRemoteDatasource {
  final HttpHelper http;

  ProductsRemoteDatasourceImpl({required this.http});

  @override
  Future<List<Product>> getProducts() async {
    final response = http.handleApiCall(
      () => http.get('/Product'),
    );
    final data = json.encode(response) as List;
    return data
        .map(
          (e) => ProductModel.fromMap(e),
        )
        .toList();
  }
}
