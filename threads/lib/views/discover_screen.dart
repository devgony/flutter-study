import 'package:flutter/widgets.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  static const String routeName = 'discover';
  static const String routeURL = '/discover';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('discover'),
    );
  }
}
