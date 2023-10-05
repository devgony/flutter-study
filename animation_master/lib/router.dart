import 'package:animation_master/day57_implicit_animations.dart';
import 'package:animation_master/day59_explicit_animations.dart';
import 'package:animation_master/menu_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/${const Day59ExplicitAnimations()}",
    routes: [
      _getRoute(const MenuScreen()),
      _getRoute(const Day57ImplicitAnimations()),
      _getRoute(const Day59ExplicitAnimations())
    ],
  );
});

GoRoute _getRoute(Widget screen) => GoRoute(
      name: screen.toString(),
      builder: (context, state) => screen,
      path: "/$screen",
    );
