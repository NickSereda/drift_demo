import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_demo/todos_module/domain/daos/todo_dao.dart';
import 'package:drift_demo/todos_module/domain/entities/todo_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'app_db.g.dart';

@singleton
@DriftDatabase(tables: [Todo], daos: [TodoDao])
class AppDb extends _$AppDb {
  AppDb({
    // For testing purposes, to be able to pass
    // NativeDatabase.memory() in tests
    QueryExecutor? queryExecutor,
    isTestDb = false,
  }) : super(
          !isTestDb ? _openConnection() : queryExecutor!,
        );

  /// Method to be used as QueryExecutor in prod environment
  static _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final File file = File(join(dbFolder.path, "todos.sqlite"));
      return NativeDatabase(file);
    });
  }

  @override
  int get schemaVersion => 1;

  @disposeMethod
  @override
  Future<void> close() {
    return super.close();
  }
}
