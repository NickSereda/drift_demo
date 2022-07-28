import 'package:drift_demo/todos_module/presentation/screens/add_todo_screen.dart';
import 'package:drift_demo/todos_module/presentation/screens/home_screen.dart';
import 'package:auto_route/auto_route.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    MaterialRoute(
      page: HomeScreen,
      initial: true,
    ),
    MaterialRoute(
      page: AddTodoScreen,
      path: AddTodoScreen.path,
    ),
  ],
)

class $AppRouter {}
