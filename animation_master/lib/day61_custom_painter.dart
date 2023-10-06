import 'dart:math';

import 'package:animation_master/homework_screen.dart';
import 'package:flutter/material.dart';

class Day61CustomPainter extends StatefulWidget {
  const Day61CustomPainter({super.key});

  @override
  State<Day61CustomPainter> createState() => _Day61CustomPainterState();
}

class _Day61CustomPainterState extends State<Day61CustomPainter>
    with SingleTickerProviderStateMixin {
  bool _isRunning = false;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  late final Animation<double> _progress = Tween(
    begin: 1.0,
    end: 0.0,
  ).animate(_animationController);

  @override
  Widget build(BuildContext context) {
    return HomeworkScreen(
      title: 'Day61-Custom Painter',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => CustomPaint(
                  painter: PomodoroPainter(progress: _progress.value),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        _progress.value.toSeconds(),
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.refresh),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _isRunning = false;
                    _animationController.value = 0;
                  });
                },
                iconSize: 50,
                splashRadius: 25,
              ),
              IconButton(
                icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _isRunning = !_isRunning;
                    if (_isRunning) {
                      _animationController.forward();
                    } else {
                      _animationController.stop();
                    }
                  });
                },
                iconSize: 50,
                splashRadius: 25,
              ),
              IconButton(
                icon: const Icon(Icons.stop),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    _isRunning = false;
                    _animationController.value = 1;
                  });
                },
                iconSize: 50,
                splashRadius: 25,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PomodoroPainter extends CustomPainter {
  final double progress;

  PomodoroPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 25
      ..style = PaintingStyle.stroke;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    canvas.drawCircle(center, radius, paint);

    final paint2 = paint
      ..color = Colors.red
      ..strokeCap = StrokeCap.round;
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, -0.5 * pi, 2 * progress * pi, false, paint2);
  }

  @override
  bool shouldRepaint(covariant PomodoroPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

extension on double {
  String toSeconds() {
    final seconds = (this * 60).floor().toString().padLeft(2, '0');
    final miliseconds =
        ((this * 60) % 1 * 100).floor().toString().padLeft(2, '0');
    return '$seconds:$miliseconds';
  }
}
