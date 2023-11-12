import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'day57_implicit_animations.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            HomeworkButton(widget: Day57ImplicitAnimations()),
          ],
        ),
      ),
    );
  }
}

class HomeworkButton extends StatelessWidget {
  final Widget widget;
  const HomeworkButton({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.pushNamed(widget.toString()),
      child: Text(widget.toString()),
    );
  }
}
