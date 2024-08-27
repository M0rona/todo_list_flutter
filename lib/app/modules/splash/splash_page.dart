import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Future.delayed(const Duration(seconds: 2)).then((value) {
    //     // ignore: use_build_context_synchronously
    //     Navigator.pushReplacementNamed(context, '/login');
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: TodoListLogo()),
    );
  }
}
