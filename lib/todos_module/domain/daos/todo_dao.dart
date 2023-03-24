import 'package:drift/drift.dart';
import 'package:drift_demo/todos_module/infrastructure/services/database/app_db.dart';
import 'package:drift_demo/todos_module/domain/entities/todo_entity.dart';

part 'todo_dao.g.dart';

@DriftAccessor(tables: [Todo])
class TodoDao extends DatabaseAccessor<AppDb> with _$TodoDaoMixin {
  final AppDb db;

  TodoDao(this.db) : super(db);

  Future<List<TodoData>> getTodos() async {
    return await select(todo).get();
  }

  Future<TodoData> getTodo(int id) async {
    return await (select(todo)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<bool> updateTodo(TodoCompanion entry) async {
    return await update(todo).replace(entry);
  }

  Future<int> addTodo(TodoCompanion entity) async {
    return await into(todo).insert(entity);
  }

  Future<int> removeTodo(int id) async {
    return await (delete(todo)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .go();
  }
}
