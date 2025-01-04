import '../../../../core/helpers/http_helper.dart';
import '../../domain/use_cases/edit_account_uc.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  deleteAccount();

  Future<UserModel> editAccount(EditAccountParam param);

  Future<UserModel> getAccount();
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final HttpHelper http;

  UserRemoteDataSourceImpl({required this.http});

  @override
  deleteAccount() async {
    await http.handleApiCall(() async => await http.delete("/profile"));
  }

  @override
  Future<UserModel> getAccount() async => await http.handleApiCall(
        () async {
          final response = await http.get("/profile") as Map<String, dynamic>;
          return UserModel.fromJson(response);
        },
      );

  @override
  Future<UserModel> editAccount(EditAccountParam param) async {
    final response = await http.handleApiCall(() async => await http.put(
          "/profile",
          body: {
            "first_name": param.firstName,
            "last_name": param.lastName,
            "latitude": param.location?.latitude,
            "longitude": param.location?.longitude
          },
        )) as Map<String, dynamic>;
    return UserModel.fromJson(response);
  }
}
