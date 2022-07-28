part of 'todos_cubit.dart';

enum Status { initial, updating, updated }

class TodosState extends Equatable {
  final List<TodoCompanion> todos;
  final Status status;

  const TodosState({
    required this.todos,
    required this.status,
  });

  @override
  List<Object?> get props => [todos, status];

  TodosState copyWith({
    List<TodoCompanion>? todos,
    Status? status,
  }) {
    return TodosState(
      todos: todos ?? this.todos,
      status: status ?? this.status,
    );
  }
}
