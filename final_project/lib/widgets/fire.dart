import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Fire extends StatefulWidget {
  final double size;

  const Fire({super.key, required this.size});

  @override
  State<Fire> createState() => _FireState();
}

class _FireState extends State<Fire> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
    reverseDuration: const Duration(seconds: 3),
  )..repeat();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (LottieBuilder.asset(
      "assets/animations/fire.json",
      controller: _animationController,
      width: widget.size,
      height: widget.size,
    ));
  }
}
