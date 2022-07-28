import 'package:drift_demo/injection.dart';
import 'package:drift_demo/todos_module/application/bloc/todo_form_cubit.dart';
import 'package:drift_demo/todos_module/application/bloc/todos_cubit.dart';
import 'package:drift_demo/todos_module/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void main() {
  configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodosCubit>(
          create: (context) => getIt<TodosCubit>()..fetchTodos(),
        ),
        BlocProvider<TodoFormCubit>(create: (context) => getIt<TodoFormCubit>()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: const HomeScreen(),
      ),
    );
  }
}
