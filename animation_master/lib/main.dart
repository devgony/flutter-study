import 'package:animation_master/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp.router(routerConfig: router);
  }
}
