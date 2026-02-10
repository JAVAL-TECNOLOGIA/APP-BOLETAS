// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plantillas_dao.dart';

// ignore_for_file: type=lint
mixin _$PlantillasDaoMixin on DatabaseAccessor<AppDatabase> {
  $PlantillasLocalTable get plantillasLocal => attachedDatabase.plantillasLocal;
  PlantillasDaoManager get managers => PlantillasDaoManager(this);
}

class PlantillasDaoManager {
  final _$PlantillasDaoMixin _db;
  PlantillasDaoManager(this._db);
  $$PlantillasLocalTableTableManager get plantillasLocal =>
      $$PlantillasLocalTableTableManager(
        _db.attachedDatabase,
        _db.plantillasLocal,
      );
}
