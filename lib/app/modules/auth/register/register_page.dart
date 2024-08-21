import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: ClipOval(
              child: Container(
                color: context.primaryColor.withAlpha(20),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: context.primaryColor,
                ),
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Todo List',
                style: TextStyle(
                  fontSize: 10,
                  color: context.primaryColor,
                ),
              ),
              Text(
                'Cadastro',
                style: TextStyle(
                  fontSize: 15,
                  color: context.primaryColor,
                ),
              ),
            ],
          )),
      body: ListView(
        children: [
          const Center(
            child: TodoListLogo(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TodoListField(
                    label: "E-mail",
                  ),
                  const SizedBox(height: 20),
                  TodoListField(label: "Senha", obscureText: true),
                  const SizedBox(height: 20),
                  TodoListField(label: "Confirmar senha", obscureText: true),
                  const SizedBox(height: 20),
                  ElevatedButton(onPressed: () {}, child: const Text('Salvar'))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
