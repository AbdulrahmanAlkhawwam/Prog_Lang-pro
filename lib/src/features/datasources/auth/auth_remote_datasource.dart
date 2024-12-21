import '../../../core/helpers/http_helper.dart';
import '../../models/Location.dart';
import '../../models/user.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login(String phoneNumber, String password);

  Future<UserModel> register(
    String firstName,
    String lastName,
    String password,
    String phoneNumber,
  );

  Future<UserModel> updateUser(
    String firstName,
    String lastName,
    int phoneNumber,
    Location? location,
  );

  Future<void> deleteAccount();

  Future<void> logout();

  Future<UserModel> me();

  Future<bool> otp(String passkey);
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
          "first_name": firstName,
          "last_name": lastName,
          "phone": phoneNumber.substring(1),
          "password": password,
        },
      ) as Map<String, dynamic>;
      return UserModel.fromJson(response);
    });
  }

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
  Future<void> logout() async =>
      await http.handleApiCall(() async => await http.post("/logout"));

  @override
  Future<void> deleteAccount() async =>
      // TODO : fix this end point
      await http.handleApiCall(() async => await http.delete("/delete"));

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
  Future<UserModel> updateUser(String firstName, String lastName,
      int phoneNumber, Location? location) async {
    final response = await http.handleApiCall(() async => await http.put(
          "/profile",
          body: {
            // TODO : fix this
            "firstName": firstName,
            "lastName": lastName,
            "phone": phoneNumber,
            "location_lat": location?.latitudes,
            "location_lon": location?.longitudes
          },
        )) as Map<String, dynamic>;
    return UserModel.fromJson(response);
  }
}
