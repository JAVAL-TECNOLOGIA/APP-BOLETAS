enum SyncStatus { local, pending, synced, failed }

enum EstadoRegistro { borrador, pendienteSync, enviado, error }

String syncStatusToDb(SyncStatus s) => s.name;
SyncStatus syncStatusFromDb(String s) =>
    SyncStatus.values.firstWhere((e) => e.name == s, orElse: () => SyncStatus.local);

String estadoToDb(EstadoRegistro e) => e.name;
EstadoRegistro estadoFromDb(String s) =>
    EstadoRegistro.values.firstWhere((e) => e.name == s, orElse: () => EstadoRegistro.borrador);
