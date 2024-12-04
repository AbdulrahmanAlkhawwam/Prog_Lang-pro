import 'package:program_language_project/src/core/helpers/http_helper.dart';

abstract class AuthRemoteDatasource {
  Future<void> login(String phoneNumber, String password);
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final HttpHelper http;

  AuthRemoteDatasourceImpl({required this.http});

  @override
  Future<void> login(String phoneNumber, String password) async {
    final response = await http.handleApiCall(
      () => http
          .post("/login", body: {"phone": phoneNumber, "password": password}),
    );
  }
}
