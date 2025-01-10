import 'dart:convert';
import 'package:program_language_project/src/core/helpers/storage_helper.dart';
import 'package:program_language_project/src/features/product/data/models/product_model.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/helpers/http_helper.dart';
import '../../../order/data/models/order_model.dart';
import '../../../product/domain/entities/product.dart';

abstract class CartRemoteDataSource {
  Future<OrderModel> createOrder(List<ProductModel> products);
}

class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  final HttpHelper http;
  final StorageHelper storage;

  CartRemoteDataSourceImpl({
    required this.http,
    required this.storage,
  });

  @override
  Future<OrderModel> createOrder(List<Product> products) async {
    final response = await http.handleApiCall(
      () async => await http.post("/order",
          body: products
              .map((e) => {
                    "quantity": e.quantity,
                    "product_id": e.id,
                  })
              .toList()),
    ) as Map<String, dynamic>;
    return OrderModel.fromJson(response);
  }
}
