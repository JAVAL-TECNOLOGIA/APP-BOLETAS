import 'package:donluis_forms/features/templates/presentation/templates_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers.dart';
import '../data/templates_repository.dart';

// Provider del repo (si no lo tienes ya en app/providers.dart, lo movemos ahí)
// final templatesRepositoryProvider = Provider<TemplatesRepository>((ref) {
//   throw UnimplementedError('Define templatesRepositoryProvider en app/providers.dart');
// });

// ✅ Stream de plantillas asignadas desde Drift
// final assignedPlantillasProvider =
// StreamProvider.family<List<PlantillasLocalData>, int>((ref, userId) {
//   final repo = ref.read(templatesRepositoryProvider);
//   return repo.watchAssigned(userId);
// });

final assignedPlantillasProvider =
StreamProvider.family.autoDispose((ref, int userId) {
  final TemplatesRepository repo = ref.watch(templatesRepoProvider);
  return repo.watchAssigned(userId);
});

// Notifier (para query + sync manual)
final templatesNotifierProvider =
StateNotifierProvider.autoDispose<TemplatesNotifier, TemplatesUiState>((ref) {
  final repo = ref.watch(templatesRepoProvider);
  return TemplatesNotifier(repo);
});
