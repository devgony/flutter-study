import 'dart:math';

import 'package:animation_master/homework_screen.dart';
import 'package:flutter/material.dart';

final List<Map<String, String>> questionsAndAnswers = [
  {'question': 'What is the largest animal on Earth?', 'answer': 'Blue whale'},
  {'question': 'What is the fastest land animal?', 'answer': 'Cheetah'},
  {'question': 'What is the largest bird in the world?', 'answer': 'Ostrich'},
  {'question': 'What is the only mammal that can fly?', 'answer': 'Bat'},
  {
    'question': 'What is the most venomous animal in the world?',
    'answer': 'Jellyfish'
  },
];

enum ActiveButton {
  close,
  check,
  none,
}

class Day64FlashcardsApp extends StatefulWidget {
  const Day64FlashcardsApp({super.key});

  @override
  State<Day64FlashcardsApp> createState() => _Day64FlashcardsAppState();
}

class _Day64FlashcardsAppState extends State<Day64FlashcardsApp>
    with TickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;

  ActiveButton _active = ActiveButton.none;

  late final AnimationController _position = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
    lowerBound: (size.width + 100) * -1,
    upperBound: (size.width + 100),
    value: 0.0,
  );

  late AnimationController _progress;

  @override
  void initState() {
    _progress = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      value: 1 / 5,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  bool isFront = true;
  void onTap() {
    setState(() {
      isFront = !isFront;
    });
  }

  late final Tween<double> _rotation = Tween(
    begin: -15,
    end: 15,
  );

  late final Tween<double> _scale = Tween(
    begin: 0.8,
    end: 1,
  );

  late final Tween<double> _opacity = Tween(
    begin: 0,
    end: 1,
  );

  late final ColorTween _colorClose = ColorTween(
    begin: Colors.white,
    end: Colors.red,
  );

  late final ColorTween _colorCheck = ColorTween(
    begin: Colors.white,
    end: Colors.green,
  );

  late final ColorTween _fontColorClose = ColorTween(
    begin: Colors.red,
    end: Colors.white,
  );

  late final ColorTween _fontColorCheck = ColorTween(
    begin: Colors.green,
    end: Colors.white,
  );

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final bound = size.width - 200;
    _position.value += details.delta.dx;

    if (_position.value.isNegative && _active != ActiveButton.close) {
      setState(() {
        _active = ActiveButton.close;
      });
    }

    if (_position.value > 0 && _active != ActiveButton.check) {
      setState(() {
        _active = ActiveButton.check;
      });
    }
  }

  void _whenComplete() {
    _position.value = 0;
    setState(() {
      _index = _index == 5 ? 1 : _index + 1;
      _active = ActiveButton.none;
      _progress.animateTo(_index / 5, curve: Curves.easeOut);
      isFront = true;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final bound = size.width - 200;
    final dropZone = size.width + 100;
    if (_position.value.abs() >= bound) {
      if (_position.value.isNegative) {
        _position.animateTo((dropZone) * -1).whenComplete(_whenComplete);
      } else {
        _position.animateTo(dropZone).whenComplete(_whenComplete);
      }
    } else {
      _position.animateTo(
        0,
        curve: Curves.easeOut,
      );
    }
  }

  void _onTapClose() {
    _position
        .animateTo(
          (size.width + 100) * -1,
          curve: Curves.easeOut,
        )
        .whenComplete(_whenComplete);
    setState(() {
      _active = ActiveButton.close;
    });
  }

  void _onTapCheck() {
    _position
        .animateTo(
          (size.width + 100),
          curve: Curves.easeOut,
        )
        .whenComplete(_whenComplete);
    setState(() {
      _active = ActiveButton.check;
    });
  }

  @override
  void dispose() {
    _position.dispose();
    super.dispose();
  }

  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _position,
      builder: (context, child) {
        final angle = _rotation.transform(
              (_position.value + size.width / 2) / size.width,
            ) *
            pi /
            180;
        final valueOnWidth = _position.value.abs() / size.width;
        final scale = _scale.transform(valueOnWidth);
        // final colorClose = _colorClose.transform(valueOnWidth);
        // final colorCheck = _colorCheck.transform(valueOnWidth);
        // final fontColorClose = _fontColorClose.transform(valueOnWidth);
        // final fontColorCheck = _fontColorCheck.transform(valueOnWidth);

        final backgroundColor = ColorTween(
          begin: Colors.blue.shade400,
          end: _position.value < 0 ? Colors.red : Colors.green,
        ).transform(valueOnWidth);

        final opacity = _opacity.transform(valueOnWidth).clamp(0.0, 1.0);

        return HomeworkScreen(
          title: 'Day64-Flashcards App',
          backgroundColor: backgroundColor!,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                  style: TextStyle(
                    color: Colors.white.withOpacity(opacity),
                    fontSize: 20,
                  ), () {
                if (_position.value == 0) {
                  return '';
                } else if (_position.value < 0) {
                  return 'Need to review';
                } else {
                  return 'I got it right';
                }
              }()),
              Flexible(
                flex: 4,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: 50,
                      child: Transform.scale(
                        scale: scale,
                        child: Card(
                          index: _index == 5 ? 1 : _index + 1,
                          question:
                              questionsAndAnswers[_index == 5 ? 1 : _index]
                                  ['question']!,
                          answer: questionsAndAnswers[_index == 5 ? 1 : _index]
                              ['answer']!,
                          isFront: true,
                          onTap: onTap,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      child: GestureDetector(
                        onHorizontalDragUpdate: _onHorizontalDragUpdate,
                        onHorizontalDragEnd: _onHorizontalDragEnd,
                        child: Transform.translate(
                          offset: Offset(_position.value, 0),
                          child: Transform.rotate(
                            angle: angle,
                            child: Card(
                              index: _index,
                              question: questionsAndAnswers[_index - 1]
                                  ['question']!,
                              answer: questionsAndAnswers[_index - 1]
                                  ['answer']!,
                              isFront: isFront,
                              onTap: onTap,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: RoundLinearProgressIndicator(
                  progress: _progress.value,
                ),
                // child: LinearProgressIndicator(
                //   minHeight: 20,
                //   color: Colors.white,
                //   backgroundColor: Colors.grey.shade500,
                //   value: _progress.value,
                // ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RoundLinearProgressIndicator extends StatelessWidget {
  final double progress;

  const RoundLinearProgressIndicator({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RoundLinearProgressIndicatorPainter(
        progress: progress,
      ),
      child: Container(),
    );
  }
}

class RoundLinearProgressIndicatorPainter extends CustomPainter {
  final double progress;

  RoundLinearProgressIndicatorPainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final pathBackground = Path()
      ..moveTo(
        0,
        size.height / 2,
      )
      ..lineTo(
        size.width,
        size.height / 2,
      );
    canvas.drawPath(
      pathBackground,
      paint,
    );

    final pathProgress = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width * progress, size.height / 2);

    canvas.drawPath(
      pathProgress,
      paint..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Card extends StatefulWidget {
  final int index;
  final String question;
  final String answer;
  final bool isFront;
  final void Function() onTap;

  const Card({
    super.key,
    required this.index,
    required this.question,
    required this.answer,
    required this.isFront,
    required this.onTap,
  });

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isFront = widget.isFront;
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedSwitcher(
        transitionBuilder: (widget, animation) {
          final rotateAnimation = Tween(begin: pi, end: 0.0).animate(animation);
          return AnimatedBuilder(
            animation: rotateAnimation,
            child: widget,
            builder: (context, widget) {
              final isUnder = (ValueKey(isFront) != widget!.key);
              var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
              tilt *= isUnder ? -1.0 : 1.0;
              final value = isUnder
                  ? min(rotateAnimation.value, pi / 2)
                  : rotateAnimation.value;

              return Transform(
                transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
                alignment: Alignment.center,
                child: widget,
              );
            },
          );
        },
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeOutBack,
        duration: const Duration(milliseconds: 600),
        child: isFront
            ? Content(payload: widget.question, key: const ValueKey(true))
            : Content(
                payload: widget.answer,
                key: const ValueKey(false),
                color: Colors.grey.shade300,
              ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final String payload;
  final Color color;

  const Content({
    super.key,
    required this.payload,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      key: key,
      color: color,
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
          child: Text(
            payload,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
