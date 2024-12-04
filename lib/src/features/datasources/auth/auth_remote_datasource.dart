import 'dart:convert';

import '../../../core/helpers/http_helper.dart';
import '../../models/user.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login(String phoneNumber, String password);
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final HttpHelper http;

  AuthRemoteDatasourceImpl({required this.http});

  @override
  Future<UserModel> login(String phoneNumber, String password) async {
    return await http.handleApiCall(
      () async {
        final response = await http.post(
          "/login",
          body: {
            "phone": phoneNumber.substring(1),
            "password": password,
          },
        ) ;
        final data = json.decode(response);
        return UserModel.fromJson(data);
      },
    );
  }
}
