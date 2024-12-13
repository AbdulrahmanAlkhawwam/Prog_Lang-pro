import '../../../core/constants/strings.dart';
import '../../../core/helpers/storage_helper.dart';

abstract class AuthLocalDatasource {
  Future<bool> checkToken();

  Future<void> deleteToken();

  Future<void> saveToken(String token);
}

class AuthLocalDatasourceImpl extends AuthLocalDatasource {
  final StorageHelper storage;

  AuthLocalDatasourceImpl({required this.storage});

  @override
  Future<bool> checkToken() async {
    return storage.contains(accessTokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await storage.remove(accessTokenKey);
  }

  @override
  Future<void> saveToken(String token) async {
    await storage.setString(accessTokenKey, token);
  }
}
