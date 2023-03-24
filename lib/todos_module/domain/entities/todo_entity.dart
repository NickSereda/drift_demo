import 'package:drift/drift.dart';

class Todo extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get todoDescription => text().named("todo_description")();

  BoolColumn get isCompleted => boolean().named("todo_completed")();
}
