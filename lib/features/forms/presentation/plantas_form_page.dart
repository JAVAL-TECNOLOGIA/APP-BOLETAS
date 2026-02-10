import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers.dart';
import '../../../../core/sync/sync_models.dart';

class PlantasFormPage extends ConsumerStatefulWidget {
  final int registroLocalId;
  const PlantasFormPage({super.key, required this.registroLocalId});

  @override
  ConsumerState<PlantasFormPage> createState() => _PlantasFormPageState();
}

class _PlantasFormPageState extends ConsumerState<PlantasFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _numPlantas = TextEditingController();
  final _obs = TextEditingController();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(_loadLocal);
  }

  Future<void> _loadLocal() async {
    final local = ref.read(registrosLocalDSProvider);
    final r = await local.getByLocalId(widget.registroLocalId);
    final data = r.dataMap();

    _numPlantas.text = (data['numero_plantas'] ?? '').toString();
    _obs.text = (data['observaciones'] ?? '').toString();

    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _numPlantas.dispose();
    _obs.dispose();
    super.dispose();
  }

  Map<String, dynamic> _buildData() => {
    "numero_plantas": int.tryParse(_numPlantas.text.trim()) ?? 0,
    "observaciones": _obs.text.trim(),
  };

  @override
  Widget build(BuildContext context) {
    final local = ref.read(registrosLocalDSProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Plantas')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _numPlantas,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Número de plantas',
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _obs,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Observaciones',
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Guardar (local)'),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final messenger = ScaffoldMessenger.of(context);

                  await local.saveLocal(
                    localId: widget.registroLocalId,
                    data: _buildData(),
                    estado: EstadoRegistro.borrador,
                    syncStatus: SyncStatus.local,
                  );

                  if (!mounted) return;
                  messenger.showSnackBar(
                    const SnackBar(content: Text('Guardado local ✅')),
                  );
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.cloud_upload),
                label: const Text('Marcar para sincronizar'),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final messenger = ScaffoldMessenger.of(context);

                  await local.saveLocal(
                    localId: widget.registroLocalId,
                    data: _buildData(),
                    estado: EstadoRegistro.pendienteSync,
                    syncStatus: SyncStatus.pending,
                  );

                  if (!mounted) return;
                  messenger.showSnackBar(
                    const SnackBar(content: Text('Listo para sync ⏳')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
