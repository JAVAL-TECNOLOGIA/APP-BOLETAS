import '../../../core/storage/drift/app_database.dart';
import '../../../core/storage/drift/daos/master/campanias_dao.dart';
import '../../../core/storage/drift/daos/master/lotes_dao.dart';

class MasterLocalDs {
  final CampaniasDao campaniasDao;
  final LotesDao lotesDao;

  MasterLocalDs({
    required this.campaniasDao,
    required this.lotesDao,
  });

  Future<void> upsertCampanias(List<CampaniasTableCompanion> items) =>
      campaniasDao.upsertMany(items);

  Future<void> upsertLotes(List<LotesTableCompanion> items) =>
      lotesDao.upsertMany(items);

  Stream<List<CampaniasTableData>> watchCampanias() => campaniasDao.watchAll();
  Stream<List<LotesTableData>> watchLotes() => lotesDao.watchAll();
}
