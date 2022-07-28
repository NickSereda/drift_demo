import 'package:drift_demo/todos_module/presentation/screens/add_todo_page.dart';
import 'package:drift_demo/todos_module/presentation/screens/home_page.dart';
import 'package:auto_route/auto_route.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    MaterialRoute(
      page: HomePage,
      initial: true,
    ),
    MaterialRoute(
      page: AddTodoPage,
      path: AddTodoPage.path,
    ),
  ],
)

class $AppRouter {}
