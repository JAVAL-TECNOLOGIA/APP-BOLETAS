import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/storage/token_store.dart';
import '../core/network/dio_client.dart';

import '../features/auth/data/auth_remote_ds.dart';
import '../features/auth/data/auth_repository.dart';
import '../features/auth/presentation/auth_notifier.dart';

// ✅ Cambia esto según tu device:
// Emulator Android: http://10.0.2.2:8000
// PC/Web: http://localhost:8000  (si el backend está en la misma PC)
// Celular real: http://192.168.x.x:8000
// const baseUrl = 'http://127.0.0.1:8000';//local
const baseUrl = 'http://192.168.0.130:8000';//tablet

final tokenStoreProvider = Provider<TokenStore>((ref) => createTokenStore());

final dioClientProvider = Provider<DioClient>((ref) {
  final store = ref.read(tokenStoreProvider);
  return DioClient(baseUrl: baseUrl, tokenStore: store);
});

final authRemoteProvider = Provider<AuthRemoteDS>((ref) {
  final dio = ref.read(dioClientProvider).dio;
  return AuthRemoteDS(dio);
});

final authRepoProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    remote: ref.read(authRemoteProvider),
    tokenStore: ref.read(tokenStoreProvider),
  );
});

// ✅ ESTE ES EL QUE TE FALTABA EN APP/LOGIN
final authProvider =
NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
