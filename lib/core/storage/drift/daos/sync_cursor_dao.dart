import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/sync_cursor_table.dart';

part 'sync_cursor_dao.g.dart';

@DriftAccessor(tables: [SyncCursorLocal])
class SyncCursorDao extends DatabaseAccessor<AppDatabase>
    with _$SyncCursorDaoMixin {
  SyncCursorDao(super.db);

  Future<DateTime?> getCursor(String key) async {
    final row = await (select(syncCursorLocal)
      ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> setCursor(String key, DateTime value) async {
    await into(syncCursorLocal).insertOnConflictUpdate(
      SyncCursorLocalCompanion(
        key: Value(key),
        value: Value(value),
      ),
    );
  }

  Future<void> clearCursor(String key) async {
    await (delete(syncCursorLocal)..where((t) => t.key.equals(key))).go();
  }

  /// Leer cursor (ej: última fecha de sync)
  Future<DateTime?> getValue(String key) async {
    final row = await (select(syncCursorLocal)
      ..where((t) => t.key.equals(key)))
        .getSingleOrNull();

    return row?.value;
  }

  /// Insertar o actualizar cursor
  Future<void> upsertValue(String key, DateTime value) async {
    await into(syncCursorLocal).insertOnConflictUpdate(
      SyncCursorLocalCompanion(
        key: Value(key),
        value: Value(value),
      ),
    );
  }


}
