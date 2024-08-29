import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/services/task/task_service.dart';

class TaskCreateController extends DefaultChangeNotifier {
  final TaskService _taskService;
  DateTime? _selectedDate;

  TaskCreateController({required TaskService taskService})
      : _taskService = taskService;

  DateTime? get selectedDate => _selectedDate;
  set setSeletedDate(DateTime? value) {
    resetState();
    _selectedDate = value;
    notifyListeners();
  }

  Future<void> save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();

      if (_selectedDate != null) {
        await _taskService.save(_selectedDate!, description);
        success();
      } else {
        setError("Data da task não selecionada");
      }
    } catch (e) {
      setError("Erro ao cadastrar task");
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
