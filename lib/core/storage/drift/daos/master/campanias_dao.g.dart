// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campanias_dao.dart';

// ignore_for_file: type=lint
mixin _$CampaniasDaoMixin on DatabaseAccessor<AppDatabase> {
  $CampaniasTableTable get campaniasTable => attachedDatabase.campaniasTable;
  CampaniasDaoManager get managers => CampaniasDaoManager(this);
}

class CampaniasDaoManager {
  final _$CampaniasDaoMixin _db;
  CampaniasDaoManager(this._db);
  $$CampaniasTableTableTableManager get campaniasTable =>
      $$CampaniasTableTableTableManager(
        _db.attachedDatabase,
        _db.campaniasTable,
      );
}
