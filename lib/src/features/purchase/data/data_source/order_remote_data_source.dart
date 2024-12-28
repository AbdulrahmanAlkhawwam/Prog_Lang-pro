import 'package:program_language_project/src/core/helpers/http_helper.dart';

import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();
}

class OrderRemoteDataSourceImpl extends OrderRemoteDataSource {
  final HttpHelper http;

  OrderRemoteDataSourceImpl({required this.http});

  @override
  Future<List<OrderModel>> getOrders() async {
    final response = await http.handleApiCall(
      () async => await http.get("/order"),
    ) as List<dynamic>;
    return response.map((e) => OrderModel.fromJson(e)).toList();
  }
}
