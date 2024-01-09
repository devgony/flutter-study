import 'dart:math';

import 'package:animation_master/homework_screen.dart';
import 'package:flutter/material.dart';

class Day57ImplicitAnimations2nd extends StatefulWidget {
  const Day57ImplicitAnimations2nd({super.key});

  @override
  State<Day57ImplicitAnimations2nd> createState() =>
      _Day57ImplicitAnimations2ndState();
}

class _Day57ImplicitAnimations2ndState
    extends State<Day57ImplicitAnimations2nd> {
  bool rewind = false;

  @override
  Widget build(BuildContext context) {
    return HomeworkScreen(
      title: 'Day57-Implicit Animations 2nd',
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 2000),
        tween: Tween(begin: rewind ? 1.0 : -1.0, end: rewind ? -1.0 : 1.0),
        onEnd: () => setState(() {
          rewind = !rewind;
        }),
        builder: (context, offset, child) => Container(
          height: MediaQuery.of(context).size.height / 2,
          color: rewind ? Colors.white : Colors.black,
          child: Stack(
            children: [
              Center(
                child: Container(
                  color: Colors.white,
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Center(
                child: Transform.rotate(
                  angle: 30 * pi / 180,
                  child: CustomPaint(
                    painter: TaegeukPainter(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
              Center(
                child: Transform.rotate(
                  angle: 30 * pi / 180,
                  // angle: 0,
                  child: CustomPaint(
                    painter: GeonGon(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
              Center(
                child: Transform.rotate(
                  angle: -30 * pi / 180,
                  // angle: 0,
                  child: CustomPaint(
                    painter: GamLi(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
              rewind
                  ? Center(
                      child: Container(
                        color: Colors.black,
                        height: 350,
                        width: MediaQuery.of(context).size.width,
                      ),
                    )
                  : Container(),
              Transform.translate(
                offset:
                    Offset((MediaQuery.of(context).size.width / 2) * offset, 0),
                child: Center(
                  child: Container(
                    height: 350,
                    width: 10,
                    color: rewind ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaegeukPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintRed = Paint()..color = const Color(0xFFCD2F3A);
    final paintBlue = Paint()..color = const Color(0xFF0247A0);
    final center =
        Offset(size.width / 2, size.width / 2); // 원의 중심을 캔버스의 중심으로 설정
    final radius = size.width / 4; // 원의 반지름을 캔버스의 너비의 절반으로 설정

    // Draw the red semi-circle
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi * 1,
      pi,
      true,
      paintRed,
    );

    // Draw the blue semi-circle
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi * 2,
      pi,
      true,
      paintBlue,
    );

    // Draw the blue circle
    canvas.drawCircle(
      Offset(radius * 2.5, radius * 2),
      radius / 2,
      paintBlue,
    );

    // // Draw the red circle
    canvas.drawCircle(
      Offset(radius * 1.5, radius * 2),
      radius / 2,
      paintRed,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class GeonGon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintBlack = Paint()..color = Colors.black;
    final double lineWidth = size.width / 24;
    final double lineLength = size.height / 4;
    final double lineSpacing = lineWidth / 2;

    // Draw the "Geon" trigram (three solid lines) to the left of the center
    for (int i = 0; i < 3; i++) {
      canvas.drawRect(
        Rect.fromLTWH(
          i * (lineWidth + lineSpacing),
          size.width / 2 - lineLength / 2,
          lineWidth,
          lineLength,
        ),
        paintBlack,
      );
    }

    // Draw the "Gon" trigram (two solid lines and one broken line) to the right of the center
    for (int i = 0; i < 3; i++) {
      if (i == 1) {
        // The second line is broken
        canvas.drawRect(
          Rect.fromLTWH(
            size.width - i * (2 * lineWidth + lineSpacing),
            size.width / 2 - lineLength / 2,
            lineWidth,
            lineLength / 2 - lineSpacing / 2,
          ),
          paintBlack,
        );
        canvas.drawRect(
          Rect.fromLTWH(
            size.width - i * (2 * lineWidth + lineSpacing),
            size.width / 2 + lineSpacing / 2,
            lineWidth,
            lineLength / 2 - lineSpacing / 2,
          ),
          paintBlack,
        );
      } else {
        // The first and third lines are solid
        canvas.drawRect(
          Rect.fromLTWH(
            size.width - (i + 1) * lineWidth - i * lineSpacing,
            size.width / 2 - lineLength / 2,
            lineWidth,
            lineLength / 2 - lineSpacing / 2,
          ),
          paintBlack,
        );
        canvas.drawRect(
          Rect.fromLTWH(
            size.width - (i + 1) * lineWidth - i * lineSpacing,
            size.width / 2 + lineSpacing / 2,
            lineWidth,
            lineLength / 2 - lineSpacing / 2,
          ),
          paintBlack,
        );
        // canvas.drawRect(
        //   Rect.fromLTWH(
        //     size.width - (i + 1) * lineWidth - i * lineSpacing,
        //     size.width / 2 - lineLength / 2,
        //     lineWidth,
        //     lineLength,
        //   ),
        //   paintBlack,
        // );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class GamLi extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintBlack = Paint()..color = Colors.black;
    final double lineWidth = size.width / 24;
    final double lineLength = size.height / 4;
    final double lineSpacing = lineWidth / 2;

    // Draw the "Gam" trigram (three solid lines) to the left of the center
    for (int i = 0; i < 3; i++) {
      if (i != 1) {
        // The second line is broken
        canvas.drawRect(
          Rect.fromLTWH(
            size.width - (i + 1) * lineWidth - i * lineSpacing,
            size.width / 2 - lineLength / 2,
            lineWidth,
            lineLength / 2 - lineSpacing / 2,
          ),
          paintBlack,
        );
        canvas.drawRect(
          Rect.fromLTWH(
            size.width - (i + 1) * lineWidth - i * lineSpacing,
            size.width / 2 + lineSpacing / 2,
            lineWidth,
            lineLength / 2 - lineSpacing / 2,
          ),
          paintBlack,
        );
      } else {
        // The first and third lines are solid
        canvas.drawRect(
          Rect.fromLTWH(
            size.width - i * (2 * lineWidth + lineSpacing),
            size.width / 2 - lineLength / 2,
            lineWidth,
            lineLength,
          ),
          paintBlack,
        );
      }
    }

    // Draw the "Li" trigram (two solid lines and one broken line) to the right of the center
    for (int i = 0; i < 3; i++) {
      if (i == 1) {
        // The second line is broken
        canvas.drawRect(
          Rect.fromLTWH(
            i * (lineWidth + lineSpacing),
            size.width / 2 - lineLength / 2,
            lineWidth,
            lineLength / 2 - lineSpacing / 2,
          ),
          paintBlack,
        );
        canvas.drawRect(
          Rect.fromLTWH(
            i * (lineWidth + lineSpacing),
            size.width / 2 + lineSpacing / 2,
            lineWidth,
            lineLength / 2 - lineSpacing / 2,
          ),
          paintBlack,
        );
      } else {
        // The first and third lines are solid
        canvas.drawRect(
          Rect.fromLTWH(
            i * (lineWidth + lineSpacing),
            size.width / 2 - lineLength / 2,
            lineWidth,
            lineLength,
          ),
          paintBlack,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
