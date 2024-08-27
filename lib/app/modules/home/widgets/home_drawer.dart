import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key});
  final nameVN = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: context.primaryColor.withAlpha(70),
              ),
              child: Row(
                children: [
                  Selector<AuthProvider, String>(
                    selector: (context, authProvider) {
                      return authProvider.user?.photoURL ??
                          'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg';
                    },
                    builder: (_, value, __) => CircleAvatar(
                      backgroundImage: NetworkImage(value),
                      radius: 30,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Selector<AuthProvider, String>(
                        selector: (context, authProvider) {
                          return authProvider.user?.displayName ??
                              'Nome de usuário não informado';
                        },
                        builder: (_, value, __) => Text(
                          value,
                          style: context.textTheme.titleMedium,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Alterar nome"),
                    content: TextField(
                      decoration: const InputDecoration(labelText: "Nome"),
                      onChanged: (value) => nameVN.value = value,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final nameValue = nameVN.value;
                          if (nameValue.isNotEmpty) {
                            Loader.show(context);
                            await context
                                .read<UserService>()
                                .updateDisplayName(nameValue);

                            Loader.hide();

                            Navigator.pop(context);
                          } else {
                            Messages.of(context).showError("Nome obrigatório");
                          }
                        },
                        child: const Text('Alterar'),
                      ),
                    ],
                  ),
                );
              },
              title: const Text('Alterar Nome'),
            ),
            ListTile(
              onTap: () => context.read<AuthProvider>().logout(),
              title: const Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}
