import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/utils.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});
  static const routeName = 'privacy';
  static const routeUrl = 'privacy';

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _isPrivate = false;
  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    const lists = [
      [Icons.comment, 'Mentions'],
      [Icons.museum_outlined, 'Muted'],
      [Icons.hearing_disabled_rounded, 'Hidden Words'],
      [Icons.portable_wifi_off_outlined, 'Profiles you follow'],
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
            foregroundColor: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: const Text('Privacy'),
      ),
      body: Column(
        children: [
          const Divider(),
          SwitchListTile.adaptive(
            value: _isPrivate,
            onChanged: (v) {
              setState(() {
                _isPrivate = v;
              });
            },
            secondary: const Icon(FontAwesomeIcons.lock),
            title: const Text('Private Account'),
          ),
          ...lists
              .map(
                (e) => ListTile(
                  leading: Icon(e[0] as IconData),
                  title: Text(e[1] as String),
                  trailing: e[1] == "Mentions"
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Everyone"),
                            Icon(Icons.chevron_right)
                          ],
                        )
                      : const Icon(Icons.chevron_right),
                ),
              )
              .toList(),
          const Divider(),
          const ListTile(
            title: Text('Other privacy settings'),
            subtitle: Text(
              "Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.",
            ),
            trailing: Icon(FontAwesomeIcons.arrowUpRightFromSquare),
          ),
          const ListTile(
            leading: Icon(Icons.close),
            title: Text('Blocked Accounts'),
            trailing: Icon(FontAwesomeIcons.arrowUpRightFromSquare),
          ),
          const ListTile(
            leading: Icon(Icons.heart_broken),
            title: Text('Hide likes'),
            trailing: Icon(FontAwesomeIcons.arrowUpRightFromSquare),
          )
        ],
      ),
    );
  }
}
