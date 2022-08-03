import 'package:auto_route/auto_route.dart';
import 'package:drift_demo/todos_module/application/bloc/todo_form_bloc/todo_form_cubit.dart';
import 'package:drift_demo/todos_module/application/bloc/todos_bloc/todos_cubit.dart';
import 'package:drift_demo/todos_module/infrastructure/services/database/app_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:drift/drift.dart' as drift;

class AddTodoPage extends StatefulWidget {
  static const String path = '/add_todo_screen';

  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<TodoFormCubit, TodoFormState>(
        listener: (context, state) {
          if (state.formzStatus == FormzStatus.submissionSuccess) {
            final TodoCompanion entity = TodoCompanion(
              todoDescription: drift.Value(state.todoDescription.value),
              isCompleted: const drift.Value(false),
            );
            context.read<TodosCubit>().addTodo(entity);
            _textEditingController.clear();
            context.read<TodoFormCubit>().clearForm();
            context.router.pop();
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Add todo',
                      errorText: state.todoDescription.invalid
                          ? state.todoDescription.error?.text
                          : null,
                    ),
                    controller: _textEditingController,
                    onChanged: (_) => context
                        .read<TodoFormCubit>()
                        .onTodoChanged(_textEditingController.text),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      context
                          .read<TodoFormCubit>()
                          .onSubmit();
                    },
                    icon: const Icon(Icons.save),
                    label: const Text("Save item"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
