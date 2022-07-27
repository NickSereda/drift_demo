// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class TodoData extends DataClass implements Insertable<TodoData> {
  final int id;
  final String todoDescription;
  final bool isCompleted;
  TodoData(
      {required this.id,
      required this.todoDescription,
      required this.isCompleted});
  factory TodoData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TodoData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      todoDescription: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}todo_description'])!,
      isCompleted: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}todo_completed'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['todo_description'] = Variable<String>(todoDescription);
    map['todo_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  TodoCompanion toCompanion(bool nullToAbsent) {
    return TodoCompanion(
      id: Value(id),
      todoDescription: Value(todoDescription),
      isCompleted: Value(isCompleted),
    );
  }

  factory TodoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoData(
      id: serializer.fromJson<int>(json['id']),
      todoDescription: serializer.fromJson<String>(json['todoDescription']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'todoDescription': serializer.toJson<String>(todoDescription),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  TodoData copyWith({int? id, String? todoDescription, bool? isCompleted}) =>
      TodoData(
        id: id ?? this.id,
        todoDescription: todoDescription ?? this.todoDescription,
        isCompleted: isCompleted ?? this.isCompleted,
      );
  @override
  String toString() {
    return (StringBuffer('TodoData(')
          ..write('id: $id, ')
          ..write('todoDescription: $todoDescription, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, todoDescription, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoData &&
          other.id == this.id &&
          other.todoDescription == this.todoDescription &&
          other.isCompleted == this.isCompleted);
}

class TodoCompanion extends UpdateCompanion<TodoData> {
  final Value<int> id;
  final Value<String> todoDescription;
  final Value<bool> isCompleted;
  const TodoCompanion({
    this.id = const Value.absent(),
    this.todoDescription = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  TodoCompanion.insert({
    this.id = const Value.absent(),
    required String todoDescription,
    required bool isCompleted,
  })  : todoDescription = Value(todoDescription),
        isCompleted = Value(isCompleted);
  static Insertable<TodoData> custom({
    Expression<int>? id,
    Expression<String>? todoDescription,
    Expression<bool>? isCompleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (todoDescription != null) 'todo_description': todoDescription,
      if (isCompleted != null) 'todo_completed': isCompleted,
    });
  }

  TodoCompanion copyWith(
      {Value<int>? id,
      Value<String>? todoDescription,
      Value<bool>? isCompleted}) {
    return TodoCompanion(
      id: id ?? this.id,
      todoDescription: todoDescription ?? this.todoDescription,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (todoDescription.present) {
      map['todo_description'] = Variable<String>(todoDescription.value);
    }
    if (isCompleted.present) {
      map['todo_completed'] = Variable<bool>(isCompleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoCompanion(')
          ..write('id: $id, ')
          ..write('todoDescription: $todoDescription, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }
}

class $TodoTable extends Todo with TableInfo<$TodoTable, TodoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _todoDescriptionMeta =
      const VerificationMeta('todoDescription');
  @override
  late final GeneratedColumn<String?> todoDescription =
      GeneratedColumn<String?>('todo_description', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool?> isCompleted = GeneratedColumn<bool?>(
      'todo_completed', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (todo_completed IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [id, todoDescription, isCompleted];
  @override
  String get aliasedName => _alias ?? 'todo';
  @override
  String get actualTableName => 'todo';
  @override
  VerificationContext validateIntegrity(Insertable<TodoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('todo_description')) {
      context.handle(
          _todoDescriptionMeta,
          todoDescription.isAcceptableOrUnknown(
              data['todo_description']!, _todoDescriptionMeta));
    } else if (isInserting) {
      context.missing(_todoDescriptionMeta);
    }
    if (data.containsKey('todo_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['todo_completed']!, _isCompletedMeta));
    } else if (isInserting) {
      context.missing(_isCompletedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TodoData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TodoTable createAlias(String alias) {
    return $TodoTable(attachedDatabase, alias);
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TodoTable todo = $TodoTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todo];
}
