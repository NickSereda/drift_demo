import 'package:auto_route/auto_route.dart';
import 'package:drift_demo/todos_module/application/bloc/todo_form_bloc/todo_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

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
      body: BlocBuilder<TodoFormCubit, TodoFormState>(
        builder: (context, state) {
          return Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      helperText: '',
                      errorText: state.formzStatus.isInvalid
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
                          .onSubmit(_textEditingController)
                          .then((success) {
                        if (success) {
                          context.router.pop();
                        }
                      });
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
