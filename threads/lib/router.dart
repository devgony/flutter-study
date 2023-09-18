import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:threads/repos/auth_repo.dart';
import 'package:threads/views/camera_screen.dart';
import 'package:threads/views/login_screen.dart';
import 'package:threads/views/main_navigation_screen.dart';
import 'package:threads/views/privacy_screen.dart';
import 'package:threads/views/settings_screen.dart';
import 'package:threads/views/sign_up_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/",
    redirect: (context, state) {
      final isLoggedIn = ref.watch(authRepository).isLoggedIn;
      if (!isLoggedIn) {
        if (state.matchedLocation != SignUpScreen.routeURL &&
            state.matchedLocation != LoginScreen.routeURL) {
          return SignUpScreen.routeURL;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: SignUpScreen.routeURL,
        name: SignUpScreen.routeName,
        builder: (context, state) {
          return const SignUpScreen();
        },
      ),
      GoRoute(
        path: LoginScreen.routeURL,
        name: LoginScreen.routeName,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
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
});
