import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/task/task_create_controller.dart';
import 'package:todo_list_provider/app/modules/task/task_create_page.dart';
import 'package:todo_list_provider/app/repositories/task/task_repository.dart';
import 'package:todo_list_provider/app/repositories/task/task_repository_impl.dart';
import 'package:todo_list_provider/app/services/task/task_service.dart';
import 'package:todo_list_provider/app/services/task/task_service_impl.dart';

class TaskModule extends TodoListModule {
  TaskModule()
      : super(
          bindings: [
            Provider<TaskRepository>(
                create: (context) => TaskRepositoryImpl(
                    sqliteConnectionFactory: context.read())),
            Provider<TaskService>(
                create: (context) =>
                    TaskServiceImpl(taskRepository: context.read())),
            ChangeNotifierProvider(
                create: (context) =>
                    TaskCreateController(taskService: context.read())),
          ],
          routers: {
            '/task/create': (context) =>
                TaskCreatePage(controller: context.read()),
          },
        );
}
