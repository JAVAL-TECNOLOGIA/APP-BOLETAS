import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'session_model.dart';

class SessionRepository {
  static const _kUserId = 'session.userId';
  static const _kAccess = 'session.accessToken';
  static const _kRefresh = 'session.refreshToken';
  static const _kOfflineExp = 'session.offlineExpiresAt';

  // Cambia 30 por 7/15 si quieres
  static const int offlineDays = 30;

  final FlutterSecureStorage storage;
  SessionRepository(this.storage);

  Future<Session?> load() async {
    final userIdStr = await storage.read(key: _kUserId);
    final access = await storage.read(key: _kAccess);
    final refresh = await storage.read(key: _kRefresh);
    final offlineExpStr = await storage.read(key: _kOfflineExp);

    if (userIdStr == null || access == null || refresh == null || offlineExpStr == null) {
      return null;
    }

    final userId = int.tryParse(userIdStr);
    final offlineExp = DateTime.tryParse(offlineExpStr);

    if (userId == null || offlineExp == null) return null;

    return Session(
      userId: userId,
      accessToken: access,
      refreshToken: refresh,
      offlineExpiresAt: offlineExp,
    );
  }

  Future<void> saveSession({
    required int userId,
    required String accessToken,
    required String refreshToken,
  }) async {
    final offlineExp = DateTime.now().add(const Duration(days: offlineDays));

    await storage.write(key: _kUserId, value: userId.toString());
    await storage.write(key: _kAccess, value: accessToken);
    await storage.write(key: _kRefresh, value: refreshToken);
    await storage.write(key: _kOfflineExp, value: offlineExp.toIso8601String());
  }

  Future<void> extendOffline() async {
    final offlineExp = DateTime.now().add(const Duration(days: offlineDays));
    await storage.write(key: _kOfflineExp, value: offlineExp.toIso8601String());
  }

  Future<void> clear() async {
    await storage.delete(key: _kUserId);
    await storage.delete(key: _kAccess);
    await storage.delete(key: _kRefresh);
    await storage.delete(key: _kOfflineExp);
  }
}
