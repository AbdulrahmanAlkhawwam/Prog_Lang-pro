import '../../../../core/helpers/http_helper.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDatasource {
  Future<List<Product>> getProducts();
}

class ProductRemoteDatasourceImpl extends ProductRemoteDatasource {
  final HttpHelper http;

  ProductRemoteDatasourceImpl({required this.http});

  @override
  Future<List<Product>> getProducts() async {
    final response = http.handleApiCall(
      () => http.get('/Product'),
    );
    final data = response as List<Map<String, dynamic>>;
    return data.map((e) => ProductModel.fromMap(e)).toList();
  }
}
