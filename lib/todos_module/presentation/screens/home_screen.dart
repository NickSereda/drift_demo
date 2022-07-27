import 'package:drift_demo/todos_module/application/bloc/todos_cubit.dart';
import 'package:drift_demo/todos_module/presentation/screens/add_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
              return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Dismissible(
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      context.read<TodosCubit>().removeTodo(state.todos[index]);
                    },
                    background: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.delete, color: Colors.white),
                            Text('Remove todo',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    key: UniqueKey(),
                    child: ListTile(
                      leading: Text(state.todos[index].todoDescription.value),
                      trailing: Checkbox(
                        value: state.todos[index].isCompleted.value,
                        onChanged: (newValue) {
                          context.read<TodosCubit>().toggleCompleted(
                                isCompleted: newValue,
                                index: index,
                              );
                        },
                      ),
                    ),
                  ));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTodoScreen()));
        },
      ),
    );
  }
}
