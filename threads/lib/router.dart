import 'package:go_router/go_router.dart';
import 'package:threads/views/camera_screen.dart';
import 'package:threads/views/main_navigation_screen.dart';
import 'package:threads/views/privacy_screen.dart';
import 'package:threads/views/settings_screen.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/:tab(|search|activity|profile)",
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
      routes: [
        GoRoute(
          path: PrivacyScreen.routeUrl,
          name: PrivacyScreen.routeName,
          builder: (context, state) {
            return const PrivacyScreen();
          },
        ),
      ],
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
