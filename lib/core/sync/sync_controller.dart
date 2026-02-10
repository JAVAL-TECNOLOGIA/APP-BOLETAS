import 'package:donluis_forms/core/sync/sync_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SyncController extends StateNotifier<AsyncValue<void>> {
  final SyncService service;
  SyncController(this.service) : super(const AsyncData(null));

  Future<void> syncAll() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => service.syncAll());
  }

  Future<void> syncPlantilla(int plantillaId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => service.syncPlantilla(plantillaId));
  }
}
