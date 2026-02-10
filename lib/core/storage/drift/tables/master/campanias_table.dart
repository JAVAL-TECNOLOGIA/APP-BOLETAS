import 'package:drift/drift.dart';

class CampaniasTable extends Table {
  TextColumn get idCampania => text()(); // ID_CAMPANIA (varchar(8))
  TextColumn get descripcion => text()(); // DESCRIPCION
  IntColumn get updatedAt => integer().nullable()(); // opcional (server ts)
  @override
  Set<Column> get primaryKey => {idCampania};
}
