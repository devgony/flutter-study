import 'package:final_project/views/home_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: HomeScreen.routeURL,
  routes: [
    GoRoute(
      path: HomeScreen.routeURL,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
