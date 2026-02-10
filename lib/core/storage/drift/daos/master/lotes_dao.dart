import 'package:drift/drift.dart';
import '../../app_database.dart';
import '../../tables/master/lotes_table.dart';

part 'lotes_dao.g.dart';

@DriftAccessor(tables: [LotesTable])
class LotesDao extends DatabaseAccessor<AppDatabase> with _$LotesDaoMixin {
  LotesDao(super.db);

  Future<void> upsertMany(List<LotesTableCompanion> items) async {
    await batch((b) => b.insertAllOnConflictUpdate(lotesTable, items));
  }

  Stream<List<LotesTableData>> watchAll() => select(lotesTable).watch();

  Stream<List<LotesTableData>> watchByFundo(String idFundo) =>
      (select(lotesTable)..where((t) => t.idFundo.equals(idFundo))).watch();

  Future<void> clear() => delete(lotesTable).go();
}
