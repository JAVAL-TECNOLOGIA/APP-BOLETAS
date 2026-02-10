// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_cursor_dao.dart';

// ignore_for_file: type=lint
mixin _$SyncCursorDaoMixin on DatabaseAccessor<AppDatabase> {
  $SyncCursorLocalTable get syncCursorLocal => attachedDatabase.syncCursorLocal;
  SyncCursorDaoManager get managers => SyncCursorDaoManager(this);
}

class SyncCursorDaoManager {
  final _$SyncCursorDaoMixin _db;
  SyncCursorDaoManager(this._db);
  $$SyncCursorLocalTableTableManager get syncCursorLocal =>
      $$SyncCursorLocalTableTableManager(
        _db.attachedDatabase,
        _db.syncCursorLocal,
      );
}
