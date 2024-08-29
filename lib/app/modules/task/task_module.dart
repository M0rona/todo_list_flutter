import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/task/task_create_controller.dart';
import 'package:todo_list_provider/app/modules/task/task_create_page.dart';

class TaskModule extends TodoListModule {
  TaskModule()
      : super(
          bindings: [
            ChangeNotifierProvider(create: (_) => TaskCreateController())
          ],
          routers: {
            '/task/create': (context) =>
                TaskCreatePage(controller: context.read()),
          },
        );
}
