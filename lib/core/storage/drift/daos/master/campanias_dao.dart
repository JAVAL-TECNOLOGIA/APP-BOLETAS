import 'package:drift/drift.dart';
import '../../app_database.dart';
import '../../tables/master/campanias_table.dart';

part 'campanias_dao.g.dart';

@DriftAccessor(tables: [CampaniasTable])
class CampaniasDao extends DatabaseAccessor<AppDatabase> with _$CampaniasDaoMixin {
  CampaniasDao(super.db);

  Future<void> upsertMany(List<CampaniasTableCompanion> items) async {
    await batch((b) => b.insertAllOnConflictUpdate(campaniasTable, items));
  }

  Stream<List<CampaniasTableData>> watchAll() =>
      select(campaniasTable).watch();

  Future<List<CampaniasTableData>> getAll() =>
      select(campaniasTable).get();

  Future<void> clear() => delete(campaniasTable).go();
}
