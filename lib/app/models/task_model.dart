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
        description: task['descricao'],
        dateTime: DateTime.parse(task['data_hora']),
        isFinish: task['finalizado'] == 1,
      );

  TaskModel copyWith({
    int? id,
    String? description,
    DateTime? dateTime,
    bool? isFinish,
  }) {
    return TaskModel(
      id: id ?? this.id,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      isFinish: isFinish ?? this.isFinish,
    );
  }
}
