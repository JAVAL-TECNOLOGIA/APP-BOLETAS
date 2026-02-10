import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'session_repository.dart';
import 'session_model.dart';

final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  return SessionRepository(ref.read(secureStorageProvider));
});

final sessionProvider = FutureProvider<Session?>((ref) async {
  return ref.read(sessionRepositoryProvider).load();
});

final currentUserIdProvider = Provider<int?>((ref) {
  final sessionAsync = ref.watch(sessionProvider);
  return sessionAsync.maybeWhen(data: (s) => s?.userId, orElse: () => null);
});
