import 'package:animation_master/homework_screen.dart';
import 'package:flutter/material.dart';

class Day59ExplicitAnimations extends StatefulWidget {
  const Day59ExplicitAnimations({Key? key}) : super(key: key);

  @override
  State<Day59ExplicitAnimations> createState() =>
      _Day59ExplicitAnimationsState();
}

class _Day59ExplicitAnimationsState extends State<Day59ExplicitAnimations>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat();

  late final Animation<Decoration> _backgroundDecoration = DecorationTween(
    begin: const BoxDecoration(
      color: Colors.black,
    ),
    end: const BoxDecoration(
      color: Colors.white,
    ),
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 0.5),
    ),
  );

  late final Animation<Decoration> _whiteDecoration = DecorationTween(
    begin: const BoxDecoration(
      color: Colors.white,
    ),
    end: const BoxDecoration(
      color: Colors.transparent,
    ),
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 0.5),
    ),
  );

  late final Animation<Decoration> _blackDecoration = DecorationTween(
    begin: const BoxDecoration(
      color: Colors.transparent,
    ),
    end: const BoxDecoration(
      color: Colors.black,
    ),
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 0.5),
    ),
  );

  static const double half = 0.5;
  static const double period = half / 8;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  build(BuildContext context) {
    return HomeworkScreen(
      title: "Day59-Explicit Animations",
      child: DecoratedBoxTransition(
        decoration: _backgroundDecoration,
        child: GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
            childAspectRatio: 1,
          ),
          itemCount: 64,
          itemBuilder: (context, index) {
            final x = index % 8;
            final y = index ~/ 8;
            final isEven = (x + y) % 2 == 0;
            final interval = isEven
                ? Interval((y + 1) * period * half, (y + 1) * period)
                : Interval(
                    half + (y + 1) * period * half,
                    half + (y + 1) * period,
                  );
            final decoration = isEven ? _whiteDecoration : _blackDecoration;
            return RotationTransparentContainer(
              parent: _animationController,
              interval: interval,
              decoration: decoration,
            );
          },
        ),
      ),
    );
  }
}

class RotationTransparentContainer extends StatelessWidget {
  final Animation<double> parent;
  final Curve interval;
  final Animation<Decoration> decoration;
  const RotationTransparentContainer({
    super.key,
    required this.parent,
    required this.interval,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(
        begin: 0.0,
        end: 0.25,
      ).animate(
        CurvedAnimation(
          parent: parent,
          curve: interval,
        ).drive(CurveTween(curve: Curves.easeInOut)),
      ),
      child: DecoratedBoxTransition(
        decoration: decoration,
        child: Container(),
      ),
    );
  }
}
