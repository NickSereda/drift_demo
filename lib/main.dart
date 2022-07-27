import 'package:drift_demo/todos_module/application/bloc/todos_cubit.dart';
import 'package:drift_demo/todos_module/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodosCubit>(
      create: (context) => TodosCubit()..fetchTodos(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: const HomeScreen(),
      ),
    );
  }
}
