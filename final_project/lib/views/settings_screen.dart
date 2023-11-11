import 'package:final_project/repositories/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/breakpoints.dart';
import '../view_models/settings_view_model.dart';

class SettingsScreen extends ConsumerWidget {
  static const routeName = "settings";
  static const routeURL = "/settings";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(settingsProvider).darkMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: Breakpoints.sm,
          ),
          child: ListView(
            children: [
              SwitchListTile.adaptive(
                value: isDark,
                onChanged: (value) =>
                    ref.read(settingsProvider.notifier).setDarkMode(value),
                title: const Text("Dark mode"),
                subtitle: const Text("toggle dark mode"),
              ),
              ListTile(
                title: const Text("Log out"),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text("Are you sure?"),
                      content: const Text("Plx dont go"),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("No"),
                        ),
                        CupertinoDialogAction(
                          onPressed: () {
                            ref.read(authRepository).signOut();
                            context.go("/login");
                          },
                          isDestructiveAction: true,
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const AboutListTile(
                applicationVersion: "1.0",
                applicationLegalese: "Don't copy me",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
