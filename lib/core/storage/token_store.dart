import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TokenStore {
  Future<void> saveTokens(String access, String refresh);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clear();
}

class MobileTokenStore implements TokenStore {
  static const _access = 'access_token';
  static const _refresh = 'refresh_token';
  final _storage = const FlutterSecureStorage();

  @override
  Future<void> saveTokens(String access, String refresh) async {
    await _storage.write(key: _access, value: access);
    await _storage.write(key: _refresh, value: refresh);
  }

  @override
  Future<String?> getAccessToken() => _storage.read(key: _access);

  @override
  Future<String?> getRefreshToken() => _storage.read(key: _refresh);

  @override
  Future<void> clear() async {
    await _storage.delete(key: _access);
    await _storage.delete(key: _refresh);
  }
}

class WebTokenStore implements TokenStore {
  static const _access = 'access_token';
  static const _refresh = 'refresh_token';

  @override
  Future<void> saveTokens(String access, String refresh) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_access, access);
    await prefs.setString(_refresh, refresh);
  }

  @override
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_access);
  }

  @override
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refresh);
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_access);
    await prefs.remove(_refresh);
  }
}

TokenStore createTokenStore() => kIsWeb ? WebTokenStore() : MobileTokenStore();
