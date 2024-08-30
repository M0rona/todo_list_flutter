import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/validators/validators.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    var defaultLister = DefaultListenerNotifier(
        changeNotifier: context.read<RegisterController>());
    defaultLister.listener(
      context: context,
      sucessCalback: (notifier, listenerInstace) {
        listenerInstace.dispose();
        // Removido devido a alteração do AuthProvider
        // Navigator.pop(context);
      },
    );
  }

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
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TodoListField(
                    label: "E-mail",
                    controller: _emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Email obrigatório'),
                      Validatorless.email('E-mail inválido'),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TodoListField(
                    label: "Senha",
                    obscureText: true,
                    controller: _passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.min(
                        6,
                        'A senha precisa ter no mínimo 6 caracteres',
                      ),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TodoListField(
                    label: "Confirmar senha",
                    obscureText: true,
                    controller: _confirmPasswordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required(
                        'Confirmação de senha obrigatória',
                      ),
                      Validators.compare(
                        _passwordEC,
                        "As senhas precisam ser iguais!",
                      ),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;

                      if (formValid) {
                        context
                            .read<RegisterController>()
                            .registerUser(_emailEC.text, _passwordEC.text);
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
