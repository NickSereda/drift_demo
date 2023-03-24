import 'package:bloc_test/bloc_test.dart';
import 'package:drift/drift.dart';
import 'package:drift_demo/todos_module/application/bloc/todos_bloc/todos_cubit.dart';
import 'package:drift_demo/todos_module/infrastructure/services/database/app_db.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:drift/native.dart';

final getIt = GetIt.instance;

void main() {
  late AppDb appDb;
  late TodosCubit todosCubit;

  setUp(() {
    appDb = AppDb(
      isTestDb: true,
      queryExecutor: NativeDatabase.memory(),
    );
    todosCubit = TodosCubit(appDb);
  });

  tearDown(() async {
    appDb.close();
  });

  group('TodosCubit test', () {
    test('TodosCubit initial state test', () {
      expect(
        todosCubit.state,
        const TodosState(todos: [], status: Status.initial),
      );
    });

    blocTest<TodosCubit, TodosState>(
      'TodosCubit emits loading state and loaded state wiht todo '
      'when addTodo() is called',
      build: () => todosCubit,
      act: (bloc) async {
        await bloc.addTodo(
          const TodoCompanion(
            todoDescription: Value('some value'),
            isCompleted: Value(false),
          ),
        );
      },
      expect: () => [
        const TodosState(
          status: Status.updating,
          todos: [],
        ),
        const TodosState(
          status: Status.updated,
          todos: [
            TodoCompanion(
              todoDescription: Value('some value'),
              isCompleted: Value(false),
            ),
          ],
        ),
      ],
    );

    blocTest<TodosCubit, TodosState>(
      'fetching todos test',
      build: () => todosCubit,
      act: (bloc) async {
        await appDb.todoDao.addTodo(
          const TodoCompanion(
            todoDescription: Value('some test value1'),
            isCompleted: Value(false),
          ),
        );
        await bloc.fetchTodos();
      },
      expect: () => [
        const TodosState(
          status: Status.updating,
          todos: [],
        ),
        const TodosState(
          status: Status.updated,
          todos: [
            TodoCompanion(
              id: Value(1),
              todoDescription: Value('some test value1'),
              isCompleted: Value(false),
            ),
          ],
        ),
      ],
    );
  });
}
