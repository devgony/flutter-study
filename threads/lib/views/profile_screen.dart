import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const String routeURL = '/profile';
  static const String routeName = 'profile';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('profile'),
    );
  }
}
