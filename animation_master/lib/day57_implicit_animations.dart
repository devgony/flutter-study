import 'dart:math';

import 'package:animation_master/homework_screen.dart';
import 'package:animation_master/utils.dart';
import 'package:flutter/material.dart';

class Day57ImplicitAnimations extends StatefulWidget {
  const Day57ImplicitAnimations({Key? key}) : super(key: key);

  @override
  State<Day57ImplicitAnimations> createState() =>
      _Day57ImplicitAnimationsState();
}

class _Day57ImplicitAnimationsState extends State<Day57ImplicitAnimations>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // _controller 선언
  // late Tween<Offset> _tween; // Define _tween variable
  late Offset begin;
  late Offset end;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeworkScreen(
      title: 'Day57-Implicit Animations',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest.width / 10;
          return GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 10,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: List.generate(
              100,
              (index) {
                final x = index % 10;
                final y = index ~/ 10;
                const mid = 4.5;
                final distance = sqrt(pow(x - mid, 2) + pow(y - mid, 2)) * 0.02;
                final random = distance * Random().nextDouble();
                final xDirection = x - mid > 0 ? 1 : -1;
                final yDirection = y - mid > 0 ? 1 : -1;
                begin = Offset.zero;
                end = Offset(xDirection * random, yDirection * random);
                return TweenAnimationBuilder(
                  tween: Tween(begin: begin, end: end),
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                  builder: (context, offset, child) {
                    return Transform(
                      transform: Matrix4.skew(
                        offset.dx,
                        offset.dy,
                      ),
                      child: Transform.translate(
                        offset: offset * size * 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: getColor(index),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    );
                  },
                  onEnd: () {
                    setState(() {
                      // Offset temp = begin;
                      // begin = end;
                      // end = temp;
                      // _controller.repeat();
                    });
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
