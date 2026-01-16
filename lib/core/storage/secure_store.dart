import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStore {
  static const _access = 'access_token';
  static const _refresh = 'refresh_token';

  final _storage = const FlutterSecureStorage();

  Future<void> saveTokens(String access, String refresh) async {
    await _storage.write(key: _access, value: access);
    await _storage.write(key: _refresh, value: refresh);
  }

  Future<String?> getAccessToken() => _storage.read(key: _access);
  Future<String?> getRefreshToken() => _storage.read(key: _refresh);

  Future<void> clear() async {
    await _storage.delete(key: _access);
    await _storage.delete(key: _refresh);
  }
}
