import '../../../../core/helpers/http_helper.dart';
import '../../domain/use_cases/edit_account_uc.dart';
import '../../domain/use_cases/login_uc.dart';
import '../../domain/use_cases/register_uc.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> deleteAccount();

  Future<UserModel> editAccount(EditAccountParam param);

  Future<UserModel> getAccount();

  Future<UserModel> login(LoginParam param);

  Future<void> logout();

  Future<bool> otp(String passkey);

  Future<UserModel> register(RegisterParam param);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final HttpHelper http;

  AuthRemoteDataSourceImpl({required this.http});

  @override
  Future<void> deleteAccount() async =>
      await http.handleApiCall(() async => await http.delete("/profile"));

  @override
  Future<UserModel> getAccount() async => await http.handleApiCall(
        () async {
          final response = await http.get("/profile") as Map<String, dynamic>;
          return UserModel.fromJson(response);
        },
      );

  @override
  Future<UserModel> login(LoginParam param) async {
    return await http.handleApiCall(
      () async {
        final response = await http.post(
          "/login",
          body: {
            "phone": param.phone.substring(1),
            "password": param.password,
          },
        ) as Map<String, dynamic>;
        return UserModel.fromJson(response);
      },
    );
  }

  @override
  Future<void> logout() async =>
      await http.handleApiCall(() async => await http.post("/logout"));

  @override
  Future<bool> otp(String passkey) async {
    return await http.handleApiCall(() async {
      final response = await http.post(
        "/register/otp",
        body: {"otp": passkey},
      ) as Map<String, dynamic>;
      return response["status"];
    });
  }

  @override
  Future<UserModel> editAccount(EditAccountParam param) async {
    final response = await http.handleApiCall(() async => await http.put(
          "/profile",
          body: {
            "first_name": param.firstName,
            "last_name": param.lastName,
            "latitude": param.location.latitudes,
            "longitude": param.location.longitudes
          },
        )) as Map<String, dynamic>;
    return UserModel.fromJson(response);
  }

  @override
  Future<UserModel> register(RegisterParam param) async {
    return await http.handleApiCall(() async {
      final response = await http.post(
        "/register",
        body: {
          "first_name": param.firstName,
          "last_name": param.lastName,
          "phone": param.phone.substring(1),
          "password": param.password,
        },
      ) as Map<String, dynamic>;
      return UserModel.fromJson(response);
    });
  }
}
