import '../../features/registros/data/registros_remote_ds.dart';
import '../../features/registros/data/registros_local_ds.dart';

class SyncService {
  final RegistrosLocalDS local;
  final RegistrosRemoteDS remote;

  SyncService({required this.local, required this.remote});

  Future<void> syncAll() async {
    final pending = await local.listPending();
    for (final r in pending) {
      try {
        final serverId = await remote.upsertRegistro(r.toApiPayload());
        await local.markSynced(r.localId, serverId);
      } catch (e) {
        await local.markFailed(r.localId, e.toString());
      }
    }
  }

  Future<void> syncPlantilla(int plantillaId) async {
    final pending = await local.listPending(plantillaId: plantillaId);
    for (final r in pending) {
      try {
        final serverId = await remote.upsertRegistro(r.toApiPayload());
        await local.markSynced(r.localId, serverId);
      } catch (e) {
        await local.markFailed(r.localId, e.toString());
      }
    }
  }
}
