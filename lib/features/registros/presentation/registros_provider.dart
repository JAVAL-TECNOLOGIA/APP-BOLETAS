import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers.dart';
import '../data/registros_local_ds.dart';
import '../domain/registro.dart';

typedef RegistrosParams = ({int plantillaId, String templateKey});

final registrosNotifierProvider = StateNotifierProvider.family<
    RegistrosNotifier, AsyncValue<List<Registro>>, RegistrosParams>((ref, params) {
  final local = ref.read(registrosLocalDSProvider);
  final userId = ref.read(currentUserIdProvider);

  return RegistrosNotifier(
    local: local,
    plantillaId: params.plantillaId,
    templateKey: params.templateKey,
    userId: userId,
  );
});

class RegistrosNotifier extends StateNotifier<AsyncValue<List<Registro>>> {
  final RegistrosLocalDS local;
  final int plantillaId;
  final String templateKey;
  final int userId;

  RegistrosNotifier({
    required this.local,
    required this.plantillaId,
    required this.templateKey,
    required this.userId,
  }) : super(const AsyncLoading()) {
    local.watchByPlantilla(plantillaId).listen(
          (items) => state = AsyncData(items),
      onError: (e, st) => state = AsyncError(e, st),
    );
  }

  Future<int> createDraft() async {
    return local.createDraft(
      plantillaId: plantillaId,
      templateKey: templateKey,
      userId: userId,
    );
  }
}
