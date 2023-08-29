import 'package:flutter/widgets.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  static const String routeURL = '/post';
  static const String routeName = 'post';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('post'),
    );
  }
}
