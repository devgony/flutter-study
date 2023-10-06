import 'package:animation_master/day59_explicit_animations.dart';
import 'package:animation_master/day61_custom_painter.dart';
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
          // crossAxisAlignment: CrossAxisAlignment.center, // why does not work?
          children: const [
            HomeworkButton(widget: Day57ImplicitAnimations()),
            HomeworkButton(widget: Day59ExplicitAnimations()),
            HomeworkButton(widget: Day61CustomPainter())
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
