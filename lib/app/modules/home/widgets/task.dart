import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_provider/app/models/task_model.dart';

class Task extends StatelessWidget {
  final TaskModel model;
  final dateFormat = DateFormat('dd/MM/yyyy');

  Task({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(.4), blurRadius: 5),
          ]),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          leading: Checkbox(value: model.isFinish, onChanged: (value) {}),
          title: Text(
            model.description,
            style: TextStyle(
              decoration: model.isFinish ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            dateFormat.format(model.dateTime),
            style: TextStyle(
              decoration: model.isFinish ? TextDecoration.lineThrough : null,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1),
          ),
        ),
      ),
    );
  }
}
