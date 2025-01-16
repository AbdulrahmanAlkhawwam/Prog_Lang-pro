import '../../../../core/helpers/http_helper.dart';
import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();

  Future<void> cancelledOrder(int id);
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

  @override
  Future<void> cancelledOrder(int id)async{
    final response = await http.handleApiCall(() async=>await http.delete("/order/cancelled/$id"));
return;
  }
}
