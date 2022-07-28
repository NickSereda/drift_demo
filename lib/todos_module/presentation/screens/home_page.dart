import 'package:auto_route/auto_route.dart';
import 'package:drift_demo/todos_module/application/bloc/todos_bloc/todos_cubit.dart';
import 'package:drift_demo/todos_module/presentation/screens/add_todo_screen.dart';
import 'package:drift_demo/todos_module/presentation/widgets/todo_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TodosCubit, TodosState>(
        buildWhen: (prevState, currState) =>
            prevState.status != currState.status,
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              return TodoListItem(index: index, todoCompanion: state.todos[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.router.pushNamed(AddTodoPage.path);
        },
      ),
    );
  }
}
