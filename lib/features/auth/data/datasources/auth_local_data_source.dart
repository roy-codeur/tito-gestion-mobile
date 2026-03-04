import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSource {
  final _storage = const FlutterSecureStorage();

  Future<String?> getToken() {
    return _storage.read(key: 'auth_token');
  }

  Future<void> saveToken(String token) {
    return _storage.write(key: 'auth_token', value: token);
  }

  Future<void> logout() {
    return _storage.delete(key: 'auth_token');
  }
}
