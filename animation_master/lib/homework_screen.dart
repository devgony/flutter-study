import 'package:flutter/material.dart';

class HomeworkScreen extends StatelessWidget {
  final String title;
  final Widget child;
  final Color backgroundColor;
  const HomeworkScreen({
    required this.title,
    Key? key,
    required this.child,
    this.backgroundColor = Colors.white24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: child,
        ),
      ),
    );
  }
}
