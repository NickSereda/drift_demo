import 'package:drift_demo/core/application/app_router.gr.dart';
import 'package:drift_demo/injection.dart';
import 'package:drift_demo/todos_module/application/bloc/todo_form_bloc/todo_form_cubit.dart';
import 'package:drift_demo/todos_module/application/bloc/todos_bloc/todos_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void main() {
  configureInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  // make sure you don't initiate your router
  // inside of the build function.
   final _appRouter = AppRouter();

   @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodosCubit>(
          create: (context) => getIt<TodosCubit>()..fetchTodos(),
        ),
        BlocProvider<TodoFormCubit>(create: (context) => TodoFormCubit()),
      ],
      child: MaterialApp.router(
        theme: ThemeData.dark(),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
