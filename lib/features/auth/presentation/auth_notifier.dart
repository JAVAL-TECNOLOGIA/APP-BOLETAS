import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers.dart';

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
  AuthState build() => const AuthState();

  Future<void> login(String username, String password) async {
    state = state.copyWith(loading: true, error: null);
    try {
      final repo = ref.read(authRepoProvider);
      await repo.login(username, password);
      state = state.copyWith(loading: false, loggedIn: true);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> logout() async {
    await ref.read(authRepoProvider).logout();
    state = const AuthState();
  }
}
