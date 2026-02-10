import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers.dart';
import '../../../core/storage/session_store.dart';

final sessionStoreProvider = Provider<SessionStore>((ref) {
  return SessionStore(const FlutterSecureStorage());
});

class AuthState {
  final bool loading;
  final bool loggedIn;
  final String? error;

  const AuthState({this.loading = false, this.loggedIn = false, this.error});

  AuthState copyWith({bool? loading, bool? loggedIn, String? error}) {
    return AuthState(
      loading: loading ?? this.loading,
      loggedIn: loggedIn ?? this.loggedIn,
      error: error,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    // ✅ al arrancar, intenta entrar sin login si la sesión offline sigue válida
    _bootstrap();
    return const AuthState(loading: true);
  }

  Future<void> _bootstrap() async {
    try {
      final ok = await ref.read(sessionStoreProvider).isOfflineSessionValid();
      state = state.copyWith(loading: false, loggedIn: ok, error: null);
    } catch (e) {
      state = state.copyWith(loading: false, loggedIn: false, error: e.toString());
    }
  }

  Future<void> login(String username, String password) async {
    state = state.copyWith(loading: true, error: null);

    try {
      final repo = ref.read(authRepoProvider);
      final result = await repo.login(username, password);

      // ✅ PASO 7: guardar “sesión offline” (30 días)
      await ref.read(sessionStoreProvider).saveOfflineSession(userId: result.userId);

      state = state.copyWith(loading: false, loggedIn: true);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> logout() async {
    await ref.read(authRepoProvider).logout();
    await ref.read(sessionStoreProvider).clear(); // ✅ limpia sesión offline
    state = const AuthState();
  }
}
