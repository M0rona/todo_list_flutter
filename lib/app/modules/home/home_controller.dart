import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';
import 'package:todo_list_provider/app/services/task/task_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TaskService _taskService;
  var filterSeleted = TaskFilterEnum.today;
  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];

  HomeController({required TaskService taskService})
      : _taskService = taskService;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _taskService.getToday(),
      _taskService.getTomorrow(),
      _taskService.getWeek(),
    ]);

    final todayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;

    todayTotalTasks = TotalTasksModel(
      totalTasks: todayTasks.length,
      totalTasksFinish: todayTasks.where((task) => task.isFinish).length,
    );

    tomorrowTotalTasks = TotalTasksModel(
      totalTasks: tomorrowTasks.length,
      totalTasksFinish: tomorrowTasks.where((task) => task.isFinish).length,
    );

    weekTotalTasks = TotalTasksModel(
      totalTasks: weekTasks.tasks.length,
      totalTasksFinish: weekTasks.tasks.where((task) => task.isFinish).length,
    );

    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSeleted = filter;
    showLoading();
    notifyListeners();
    List<TaskModel> tasks;

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _taskService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _taskService.getTomorrow();
        break;
      case TaskFilterEnum.week:
        tasks = (await _taskService.getWeek()).tasks;
        break;
    }

    filteredTasks = tasks;
    allTasks = tasks;

    hideLoading();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTasks(filter: filterSeleted);
    await loadTotalTasks();
    notifyListeners();
  }
}
