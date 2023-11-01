import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threads/views/privacy_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const routeName = 'settings';
  static const routeUrl = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _loggingOut = false;
  @override
  Widget build(BuildContext context) {
    const lists = [
      [Icons.person, 'Follow and invite friends'],
      [Icons.notification_add, 'Notificatoins'],
      [Icons.privacy_tip, 'Privacy'],
      [Icons.person, 'Account'],
      [Icons.help, 'Help'],
      [Icons.info, 'About'],
    ];

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 94,
        leading: TextButton.icon(
          icon: const Icon(Icons.arrow_back_ios),
          label: const Text('Back'),
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
          ),
        ),
        title: const Text('Settings'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          ...lists
              .map(
                (e) => ListTile(
                  leading: Icon(e[0] as IconData),
                  title: Text(e[1] as String),
                  onTap: e[1] == "Privacy"
                      ? () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PrivacyScreen(),
                            ),
                          )
                      : null,
                ),
              )
              .toList(),
          const Divider(),
          ListTile(
            title: const Text(
              'Log out',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
            onTap: () {
              setState(() {
                _loggingOut = true;
              });
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
                      onPressed: () => Navigator.of(context).pop(),
                      isDestructiveAction: true,
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              ).then(
                (value) => setState(() {
                  _loggingOut = false;
                }),
              );
            },
            trailing: _loggingOut
                ? const CircularProgressIndicator.adaptive()
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
