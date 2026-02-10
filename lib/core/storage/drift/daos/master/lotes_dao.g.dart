// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lotes_dao.dart';

// ignore_for_file: type=lint
mixin _$LotesDaoMixin on DatabaseAccessor<AppDatabase> {
  $LotesTableTable get lotesTable => attachedDatabase.lotesTable;
  LotesDaoManager get managers => LotesDaoManager(this);
}

class LotesDaoManager {
  final _$LotesDaoMixin _db;
  LotesDaoManager(this._db);
  $$LotesTableTableTableManager get lotesTable =>
      $$LotesTableTableTableManager(_db.attachedDatabase, _db.lotesTable);
}
