import 'package:animation_master/day57_implicit_animations.dart';
import 'package:animation_master/day59_explicit_animations.dart';
import 'package:animation_master/day61_custom_painter.dart';
import 'package:animation_master/day64_flashcards_app.dart';
import 'package:animation_master/menu_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: "/${const MenuScreen()}",
  routes: [
    _getRoute(const MenuScreen()),
    _getRoute(const Day57ImplicitAnimations()),
    _getRoute(const Day59ExplicitAnimations()),
    _getRoute(const Day61CustomPainter()),
    _getRoute(const Day64FlashcardsApp())
  ],
);

GoRoute _getRoute(Widget screen) => GoRoute(
      name: screen.toString(),
      builder: (context, state) => screen,
      path: "/$screen",
    );
