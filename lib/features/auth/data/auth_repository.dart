import '../../../core/storage/token_store.dart';
import 'auth_remote_ds.dart';

class AuthRepository {
  final AuthRemoteDS remote;
  final TokenStore tokenStore;

  AuthRepository({required this.remote, required this.tokenStore});

  Future<void> login(String u, String p) async {
    final data = await remote.login(u, p);

    final access = data['access_token'] as String;
    final refresh = data['refresh_token'] as String;

    await tokenStore.saveTokens(access, refresh);
  }

  Future<void> logout() => tokenStore.clear();
}
