import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_demo/todos_module/domain/daos/todo_dao.dart';
import 'package:drift_demo/todos_module/domain/entities/todo_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'app_db.g.dart';

LazyDatabase _openConnection() {

  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final File file = File(join(dbFolder.path, "todos.sqlite"));
    return NativeDatabase(file);
  });
}

@singleton
@DriftDatabase(tables: [Todo], daos: [TodoDao])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @disposeMethod
  @override
  Future<void> close() {
    return super.close();
  }

}
