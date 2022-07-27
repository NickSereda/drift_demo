import 'package:drift/drift.dart' as drift;
import 'package:drift_demo/todos_module/application/bloc/todos_cubit.dart';
import 'package:drift_demo/todos_module/infrastructure/services/database/app_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _textEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {

                    final TodoCompanion entity = TodoCompanion(
                      todoDescription: drift.Value(_textEditingController.value.text),
                      isCompleted: const drift.Value(false),
                    );

                    context.read<TodosCubit>().addTodo(entity);
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text("Save item"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
