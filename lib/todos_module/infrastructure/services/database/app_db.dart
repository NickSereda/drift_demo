import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_demo/todos_module/domain/entities/todo_entity.dart';
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

@DriftDatabase(tables: [Todo])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<TodoData>> getTodos() async {
    return await select(todo).get();
  }

  Future<TodoData> getTodo(int id) async {
    return await (select(todo)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<bool> updateTodo(TodoCompanion newEntity) async {
    return await update(todo).replace(newEntity);
  }

  Future<int> addTodo(TodoCompanion entity) async {
    return await into(todo).insert(entity);
  }

  Future<int> removeTodo(int id) async {
    return await (delete(todo)..where((tbl) => tbl.id.equals(id))).go();
  }
}
