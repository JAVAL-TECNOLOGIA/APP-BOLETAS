import 'dart:convert';

enum SyncStatus { local, pending, synced, failed }
enum EstadoRegistro { borrador, pendienteSync, enviado, error }

class RegistroLocal {
  final int localId;
  final int plantillaId;
  final int userId;

  final SyncStatus syncStatus;
  final EstadoRegistro estado;

  final String dataJson; // siempre string JSON
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? syncError;

  RegistroLocal({
    required this.localId,
    required this.plantillaId,
    required this.userId,
    required this.syncStatus,
    required this.estado,
    required this.dataJson,
    required this.createdAt,
    required this.updatedAt,
    this.syncError,
  });

  Map<String, dynamic> dataMap() {
    try {
      final d = jsonDecode(dataJson);
      return (d is Map<String, dynamic>) ? d : <String, dynamic>{};
    } catch (_) {
      return <String, dynamic>{};
    }
  }
}

abstract class RegistrosLocalRepository {
  Future<int> createDraft({required int plantillaId, required int userId});

  Future<RegistroLocal> getByLocalId(int localId);

  Stream<List<RegistroLocal>> watchByPlantilla(int plantillaId);

  Future<void> saveLocal(
      int localId, {
        required Map<String, dynamic> data,
        required EstadoRegistro estado,
        required SyncStatus syncStatus,
      });
}
