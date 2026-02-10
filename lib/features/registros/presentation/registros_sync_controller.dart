import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';

class RegistrosSyncState {
  final bool isSyncing;
  final int current;
  final int total;
  final int ok;
  final int fail;
  final String? message;
  final String? lastError;

  const RegistrosSyncState({
    required this.isSyncing,
    required this.current,
    required this.total,
    required this.ok,
    required this.fail,
    this.message,
    this.lastError,
  });

  factory RegistrosSyncState.idle() => const RegistrosSyncState(
    isSyncing: false,
    current: 0,
    total: 0,
    ok: 0,
    fail: 0,
    message: null,
    lastError: null,
  );

  RegistrosSyncState copyWith({
    bool? isSyncing,
    int? current,
    int? total,
    int? ok,
    int? fail,
    String? message,
    String? lastError,
  }) {
    return RegistrosSyncState(
      isSyncing: isSyncing ?? this.isSyncing,
      current: current ?? this.current,
      total: total ?? this.total,
      ok: ok ?? this.ok,
      fail: fail ?? this.fail,
      message: message ?? this.message,
      lastError: lastError,
    );
  }
}

class RegistrosSyncController extends StateNotifier<RegistrosSyncState> {
  RegistrosSyncController(this.ref) : super(RegistrosSyncState.idle());

  final Ref ref;

  /// Sync contextual por templateKey (ej: 'cartilla-fito') o global si null
  Future<void> sync({String? templateKey}) async {
    if (state.isSyncing) return;

    final local = ref.read(registrosLocalDSProvider);
    final remote = ref.read(registrosRemoteDSProvider);

    // ✅ Tu DS real trae listPending({plantillaId})
    // Como no filtra por templateKey, filtramos aquí en memoria.
    // final allPendientes = await local.listPending();
    final allPendientes = await local.listSyncQueue(); // pendientes
    final pendientes = templateKey == null
        ? allPendientes
        : allPendientes.where((r) => r.templateKey == templateKey).toList();

    if (pendientes.isEmpty) {
      state = state.copyWith(
        isSyncing: false,
        current: 0,
        total: 0,
        ok: 0,
        fail: 0,
        message: 'No hay pendientes para sincronizar',
        lastError: null,
      );
      return;
    }

    state = state.copyWith(
      isSyncing: true,
      current: 0,
      total: pendientes.length,
      ok: 0,
      fail: 0,
      message: 'Sincronizando...',
      lastError: null,
    );

    for (var i = 0; i < pendientes.length; i++) {
      final r = pendientes[i];

      state = state.copyWith(
        current: i + 1,
        message: '${r.templateKey} (#${r.localId})',
      );

      try {
        // dataJson es String en tu modelo -> enviamos como Map al backend
        final Map<String, dynamic> dataMap =
        (jsonDecode(r.dataJson) as Map).cast<String, dynamic>();

        // ✅ Payload según tu backend acordado
        final payload = <String, dynamic>{
          'templateKey': r.templateKey,
          'payloadVersion': 1,
          'dataJson': dataMap,
          if (r.campaniaId != null) 'campaniaId': r.campaniaId,
          if (r.loteId != null) 'loteId': r.loteId,
          if (r.lat != null) 'lat': r.lat,
          if (r.lon != null) 'lon': r.lon,
        };

        // ✅ Tu Remote DS real se llama upsertRegistro(payload)
        final serverId = await remote.upsertRegistro(payload);

        // ✅ Tu Local DS real tiene markSynced(localId, serverId)
        await local.markSynced(r.localId, serverId);

        state = state.copyWith(ok: state.ok + 1);
      } catch (e) {
        // ✅ Tu Local DS real tiene markFailed(localId, error)
        await local.markFailed(r.localId, e.toString());

        state = state.copyWith(
          fail: state.fail + 1,
          lastError: e.toString(),
        );
      }
    }

    state = state.copyWith(
      isSyncing: false,
      message: 'Sync terminado: ${state.ok} OK, ${state.fail} con error',
    );
  }
}

final registrosSyncControllerProvider =
StateNotifierProvider<RegistrosSyncController, RegistrosSyncState>(
      (ref) => RegistrosSyncController(ref),
);
