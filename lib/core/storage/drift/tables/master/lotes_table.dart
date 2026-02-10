import 'package:drift/drift.dart';

class LotesTable extends Table {
  IntColumn get idLote => integer()(); // ID_LOTE
  TextColumn get descripcion => text()(); // DESCRIPCION
  RealColumn get areaTotal => real().nullable()(); // AREA_TOTAL decimal
  TextColumn get idFundo => text()(); // ID_FUNDO
  IntColumn get idVariedad => integer()(); // ID_VARIEDAD (bigint) -> en Dart int
  TextColumn get ceco => text()(); // CECO

  IntColumn get updatedAt => integer().nullable()(); // opcional

  @override
  Set<Column> get primaryKey => {idLote};
}
