import 'package:flutter/material.dart';
import 'package:pomodoro/views/pomodoro.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      theme: ThemeData(
        primaryColor: Colors.green[200],
      ),
      home: const Pomodoro(),
    );
  }
}
