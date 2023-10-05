import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'day57_implicit_animations.dart';
import 'day59_explicit_animations.dart';
import 'menu_screen.dart';

final router = GoRouter(
  initialLocation: "/${const MenuScreen()}",
  routes: [
    _getRoute(const MenuScreen()),
    _getRoute(const Day57ImplicitAnimations()),
    _getRoute(const Day59ExplicitAnimations())
  ],
);

GoRoute _getRoute(Widget screen) => GoRoute(
      name: screen.toString(),
      builder: (context, state) => screen,
      path: "/$screen",
    );
