import 'package:drift/drift.dart';

class SyncCursorLocal extends Table {
  TextColumn get key => text()(); // ej: templates_assigned_6066
  DateTimeColumn get value => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}
