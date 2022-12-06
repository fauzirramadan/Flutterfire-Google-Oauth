import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          Consumer<AuthProvider>(builder: (context, bloc, _) {
            return ListTile(
              onTap: () => bloc.logOut(),
              title: const Text("Log Out"),
              trailing: const Icon(Icons.logout),
            );
          })
        ],
      ),
    );
  }
}
