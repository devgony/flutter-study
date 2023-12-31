import 'package:animation_master/day57_implicit_animations_2nd.dart';
import 'package:animation_master/day59_explicit_animations.dart';
import 'package:animation_master/day61_custom_painter.dart';
import 'package:animation_master/day64_flashcards_app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'day57_implicit_animations.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeworkButton(widget: Day57ImplicitAnimations()),
            HomeworkButton(widget: Day57ImplicitAnimations2nd()),
            HomeworkButton(widget: Day59ExplicitAnimations()),
            HomeworkButton(widget: Day61CustomPainter()),
            HomeworkButton(widget: Day64FlashcardsApp()),
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
