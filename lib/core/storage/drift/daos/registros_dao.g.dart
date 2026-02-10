// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registros_dao.dart';

// ignore_for_file: type=lint
mixin _$RegistrosDaoMixin on DatabaseAccessor<AppDatabase> {
  $RegistrosLocalTable get registrosLocal => attachedDatabase.registrosLocal;
  RegistrosDaoManager get managers => RegistrosDaoManager(this);
}

class RegistrosDaoManager {
  final _$RegistrosDaoMixin _db;
  RegistrosDaoManager(this._db);
  $$RegistrosLocalTableTableManager get registrosLocal =>
      $$RegistrosLocalTableTableManager(
        _db.attachedDatabase,
        _db.registrosLocal,
      );
}
