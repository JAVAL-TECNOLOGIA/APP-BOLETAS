import 'package:donluis_forms/features/registros/presentation/registros_sync_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/form_registry.dart';
import '../../../app/providers.dart';
import '../../../core/sync/sync_models.dart';
import '../domain/registro.dart';
import 'registros_controller.dart';

class RegistrosPage extends ConsumerWidget {
  final int plantillaId;
  final String templateKey;
  final String plantillaNombre;

  const RegistrosPage({
    super.key,
    required this.plantillaId,
    required this.templateKey,
    required this.plantillaNombre,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrosAsync =
    ref.watch(registrosByPlantillaProvider(plantillaId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registros'),
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final sync = ref.watch(registrosSyncControllerProvider);
              final isBusy = sync.isSyncing;

              return IconButton(
                tooltip: isBusy
                    ? 'Sincronizando ${sync.current}/${sync.total}'
                    : 'Sincronizar pendientes',
                onPressed: isBusy
                    ? null
                    : () async {
                  await ref
                      .read(registrosSyncControllerProvider.notifier)
                      .sync(templateKey: null); // 👈 GLOBAL

                  final st = ref.read(registrosSyncControllerProvider);
                  if (context.mounted && st.message != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(st.message!),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
                },
                icon: isBusy
                    ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${sync.current}/${sync.total}'),
                    const SizedBox(width: 8),
                    const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ],
                )
                    : const Icon(Icons.sync),
              );
            },
          ),
        ],
      ),
      body: registrosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text(
                'No hay registros aún.\nPresiona + para crear uno.',
                textAlign: TextAlign.center,
              ),
            );
          }

          final formRoute = FormRegistry.routeFor(templateKey);
          debugPrint('1TEMPLATEKEY=$templateKey -> ROUTE=$formRoute');
          debugPrint('[FORM_REGISTRY] TEMPLATEKEY=$templateKey ROUTE=$formRoute');
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) => _RegistroTile(registro: items[i], formRoute: formRoute, ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Nuevo registro',
        child: const Icon(Icons.add),
        onPressed: () async {
          debugPrint('🔥 BOTON + PRESIONADO');
          final nav = Navigator.of(context); // ✅ capturado antes del await
          final local = ref.read(registrosLocalDSProvider);
          final userId = ref.read(currentUserIdProvider);

          // 1️⃣ Crear borrador local
          final localId = await local.createDraft(
            plantillaId: plantillaId,
            templateKey: templateKey,
            userId: userId,
          );

          // 2️⃣ Navegar al formulario correspondiente
          final formRoute = FormRegistry.routeFor(templateKey);
          debugPrint('2TEMPLATEKEY=$templateKey -> ROUTE=$formRoute');

          nav.pushNamed(
            formRoute,
            arguments: {'localId': localId},
          );
        },
      ),

    );
  }
}

class _RegistroTile extends StatelessWidget {
  final Registro registro;
  final String formRoute;
  const _RegistroTile({
    required this.registro,
    required this.formRoute,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _StatusIcon(registro.syncStatus),
      title: Text('Registro #${registro.localId}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Estado: ${registro.estado.name}'),
          if (registro.syncError != null)
            Text(
              'Error: ${registro.syncError}',
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // Abrir el formulario para editar
          Navigator.pushNamed(
            context,
            formRoute,
            arguments: {'localId': registro.localId},
          );
      },
    );
  }
}

class _StatusIcon extends StatelessWidget {
  final SyncStatus status;
  const _StatusIcon(this.status);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case SyncStatus.local:
        return const Icon(Icons.edit, color: Colors.grey);
      case SyncStatus.pending:
        return const Icon(Icons.cloud_upload, color: Colors.orange);
      case SyncStatus.synced:
        return const Icon(Icons.cloud_done, color: Colors.green);
      case SyncStatus.failed:
        return const Icon(Icons.error, color: Colors.red);
    }
  }
}
