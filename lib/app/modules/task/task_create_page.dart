import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/modules/task/task_create_controller.dart';
import 'package:todo_list_provider/app/modules/task/widgets/calendar_button.dart';

class TaskCreatePage extends StatelessWidget {
  final TaskCreateController _controller;

  const TaskCreatePage({super.key, required TaskCreateController controller})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.save),
        backgroundColor: context.primaryColor,
        label: const Text(
          'Salvar task',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Criar task",
                  style: context.titleStyle,
                ),
              ),
              const SizedBox(height: 30),
              TodoListField(label: "Nome"),
              const SizedBox(height: 20),
              const CalendarButton(),
            ],
          ),
        ),
      ),
    );
  }
}
