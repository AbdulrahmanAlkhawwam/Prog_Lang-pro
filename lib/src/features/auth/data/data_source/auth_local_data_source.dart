import '../../../../core/constants/strings.dart';
import '../../../../core/helpers/storage_helper.dart';

abstract class AuthLocalDataSource {
  Future<bool> checkToken();

  Future<void> deleteToken();

  Future<void> saveToken(String token);
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final StorageHelper storage;

  AuthLocalDataSourceImpl({required this.storage});

  @override
  Future<bool> checkToken() async => storage.contains(accessTokenKey);

  @override
  Future<void> deleteToken() async => await storage.remove(accessTokenKey);

  @override
  Future<void> saveToken(String token) async =>
      await storage.setString(accessTokenKey, token);
}
