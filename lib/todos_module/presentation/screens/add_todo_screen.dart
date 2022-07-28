import 'dart:developer';

import 'package:drift/drift.dart' as drift;
import 'package:drift_demo/todos_module/application/bloc/todo_form_cubit.dart';
import 'package:drift_demo/todos_module/application/bloc/todos_cubit.dart';
import 'package:drift_demo/todos_module/domain/entities/todo_entity.dart';
import 'package:drift_demo/todos_module/infrastructure/services/database/app_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
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
         // buildWhen: (prevState, currState) => prevState.formzStatus != currState.formzStatus || prevState.todoDescription.error != currState.todoDescription.error,
        builder: (context, state) {
          log("REBUILD");
          log(state.formzStatus.name);
          log(state.todoDescription.error?.text ?? "");
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
                    onChanged: (_) => context.read<TodoFormCubit>().onTodoChanged(_textEditingController.text),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<TodoFormCubit>().onSubmit(_textEditingController).then((success) {
                        if (success) {
                          Navigator.of(context).pop();
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
