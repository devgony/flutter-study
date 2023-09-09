import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:threads/views/camera_screen.dart';
import 'package:threads/views/main_navigation_screen.dart';
import 'package:threads/views/privacy_screen.dart';
import 'package:threads/views/settings.screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/home",
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
      GoRoute(
        path: SettingsScreen.routeUrl,
        name: SettingsScreen.routeName,
        builder: (context, state) {
          return const SettingsScreen();
        },
      ),
      GoRoute(
        path: PrivacyScreen.routeUrl,
        name: PrivacyScreen.routeName,
        builder: (context, state) {
          return const PrivacyScreen();
        },
      ),
      GoRoute(
        path: CameraScreen.routeUrl,
        name: CameraScreen.routeName,
        builder: (context, state) {
          return const CameraScreen();
        },
      )
    ],
  );
});
