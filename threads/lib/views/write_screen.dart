import 'package:flutter/widgets.dart';

class WriteScreen extends StatelessWidget {
  const WriteScreen({Key? key}) : super(key: key);

  static const String routeURL = '/write';
  static const String routeName = 'write';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('write'),
    );
  }
}
