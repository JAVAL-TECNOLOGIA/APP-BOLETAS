import 'package:drift/drift.dart';

class PlantillasLocal extends Table {
  IntColumn get plantillaId => integer()(); // id del servidor (PK lógica)
  IntColumn get userId => integer()(); // para asignación por usuario

  TextColumn get codigo => text().nullable()();
  TextColumn get nombre => text().nullable()();
  TextColumn get descripcion => text().nullable()();

  IntColumn get version => integer().withDefault(const Constant(1))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {plantillaId, userId}; // asignación por usuario
}
