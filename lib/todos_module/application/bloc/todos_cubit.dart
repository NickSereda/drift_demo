import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:drift_demo/todos_module/infrastructure/services/database/app_db.dart';
import 'package:equatable/equatable.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit()
      : super(
          const TodosState(
            todos: [],
            status: Status.initial,
          ),
        );

  final AppDb _appDb = AppDb();

  Future<void> fetchTodos() async {
    emit(state.copyWith(status: Status.updating));

    final List<TodoData> todosData = await _appDb.getTodos();
    final List<TodoCompanion> todosCompanion =
        todosData.map((e) => e.toCompanion(false)).toList();
    emit(state.copyWith(todos: todosCompanion, status: Status.updated));
  }

  Future<void> addTodo(TodoCompanion entity) async {
    emit(state.copyWith(status: Status.updating));

    _appDb.addTodo(entity);

    emit(state.copyWith(todos: [
      ...state.todos,
      entity,
    ], status: Status.updated));
  }

  Future<void> removeTodo(TodoCompanion entity) async {
    emit(state.copyWith(status: Status.updating));

    _appDb.removeTodo(entity.id.value);

    List<TodoCompanion> todos = state.todos..remove(entity);
    emit(state.copyWith(todos: todos, status: Status.updated));
  }

  Future<void> toggleCompleted({
    bool? isCompleted,
    required int index,
  }) async {
    emit(state.copyWith(status: Status.updating));


    final TodoCompanion updatedTodo = state.todos[index].copyWith(isCompleted: Value(isCompleted!));

    _appDb.updateTodo(updatedTodo);

    final List<TodoCompanion> todos = state.todos;
    todos[index] = updatedTodo;

    emit(state.copyWith(todos: todos, status: Status.updated));
  }

  @override
  Future<void> close() {
    _appDb.close();
    return super.close();
  }
}
