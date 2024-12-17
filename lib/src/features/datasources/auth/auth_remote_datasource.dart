import '../../../core/helpers/http_helper.dart';
import '../../models/user.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login(String phoneNumber, String password);

  Future<UserModel> register(
    String firstName,
    String lastName,
    String password,
    String phoneNumber,
  );

  Future<void> logout();

  Future<UserModel> me();
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
        ) as Map<String, dynamic>;
        return UserModel.fromJson(response);
      },
    );
  }

  @override
  Future<UserModel> me() async {
    return await http.handleApiCall(
      () async {
        final response = await http.get("/profile") as Map<String, dynamic>;
        return UserModel.fromJson(response);
      },
    );
  }

  @override
  Future<void> logout() async =>
      await http.handleApiCall(() async => await http.post("/logout"));

  @override
  Future<UserModel> register(
    String firstName,
    String lastName,
    String password,
    String phoneNumber,
  ) async {
    return await http.handleApiCall(() async {
      final response = await http.post(
        "/register",
        body: {
          "firstname": firstName,
          "lastname": lastName,
          "phone": phoneNumber.substring(1),
          "password": password,
        },
      ) as Map<String, dynamic>;
      return UserModel.fromJson(response);
    });
  }
}
