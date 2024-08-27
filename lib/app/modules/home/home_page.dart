import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Logout'),
          onPressed: () {
            context.read<AuthProvider>().logout();
          },
        ),
      ),
    );
  }
}
