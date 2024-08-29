import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_filters.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_header.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_tasks.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_week_filter.dart';
import 'package:todo_list_provider/app/modules/task/task_module.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goToCreateTask(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(
            parent: animation,
            curve: Curves.fastEaseInToSlowEaseOut,
          );

          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) =>
            TaskModule().getPage("/task/create", context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.primaryColor),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.filter_alt_sharp),
            itemBuilder: (_) => [
              const PopupMenuItem<bool>(
                child: Text("Mostrar tarefas concluidas"),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primaryColor,
        onPressed: () => _goToCreateTask(context),
        child: const Icon(Icons.add),
      ),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: const IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeHeader(),
                  HomeFilters(),
                  HomeWeekFilter(),
                  HomeTasks(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
