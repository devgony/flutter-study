import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:threads/views/main_navigation_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/activity",
    // redirect: (context, state) {
    //   return null;
    // },
    routes: [
      GoRoute(
        path: "/:tab(home|search|activity|profile)",
        name: MainNavigationScreen.routeName,
        builder: (context, state) {
          final tab = state.pathParameters["tab"]!;
          return MainNavigationScreen(tab: tab);
        },
      ),
    ],
  );
});
