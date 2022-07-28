import 'package:drift_demo/todos_module/application/bloc/todos_bloc/todos_cubit.dart';
import 'package:drift_demo/todos_module/infrastructure/services/database/app_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoListItem extends StatelessWidget {
  final int index;
  final TodoCompanion todoCompanion;

  const TodoListItem({
    Key? key,
    required this.index,
    required this.todoCompanion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          context.read<TodosCubit>().removeTodo(todoCompanion);
        },
        background: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(Icons.delete, color: Colors.white),
                Text('Remove todo', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
        key: UniqueKey(),
        child: ListTile(
          leading: Text(todoCompanion.todoDescription.value),
          trailing: Checkbox(
            value: todoCompanion.isCompleted.value,
            onChanged: (newValue) {
              context.read<TodosCubit>().toggleCompleted(
                    isCompleted: newValue,
                    index: index,
                  );
            },
          ),
        ),
      ),
    );
  }
}
