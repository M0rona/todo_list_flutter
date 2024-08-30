class TaskModel {
  final int id;
  final String description;
  final DateTime dateTime;
  final bool isFinish;

  TaskModel({
    required this.id,
    required this.description,
    required this.dateTime,
    required this.isFinish,
  });

  factory TaskModel.loadFromDb(Map<String, dynamic> task) => TaskModel(
        id: task['id'],
        description: task['description'],
        dateTime: DateTime.parse(task['date_hora']),
        isFinish: task['is_finish'] == 1,
      );
}
