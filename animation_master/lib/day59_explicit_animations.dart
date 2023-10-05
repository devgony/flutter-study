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

  // late final CurvedAnimation _curve = CurvedAnimation(
  //   parent: _animationController,
  //   curve: Curves.elasticOut,
  //   reverseCurve: Curves.bounceIn,
  // );

  // late final Animation<double> _rotationForward = Tween(
  //   begin: 0.0,
  //   end: 0.25,
  // ).animate(_animationController);

  // late final Animation<double> _rotationHold = Tween(
  //   begin: 0.0,
  //   end: 0.0,
  // ).animate(_animationController);

  late final Animation<Decoration> _decoration = DecorationTween(
    begin: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(0),
    ),
    end: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0),
    ),
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 0.5),
    ),
  );

  late final Animation<Decoration> _whiteDecoration = DecorationTween(
    begin: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0),
    ),
    end: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(0),
    ),
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 0.5),
    ),
  );

  late final Animation<Decoration> _blackDecoration = DecorationTween(
    begin: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(0),
    ),
    end: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(0),
    ),
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 0.5),
    ),
  );

  static const Curve curve = Curves.easeInOut;
  static const double interval = 0.05;
  static const double half = 0.5;
  static const double init = 0.5;

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
        decoration: _decoration,
        child: GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
            childAspectRatio: 1,
          ),
          itemCount: 100,
          itemBuilder: (context, index) {
            final x = index % 10;
            final y = index ~/ 10;
            if ((x + y) % 2 == 0) {
              return RotationTransition(
                // 0,0 0,1 0,2 0,3 0,4 0,5 0,6 0,7 0,8 0,9 => even: 0 ~ 0.05, odd: 0.5 ~ 0.55
                // 1,0 1,1 1,2 1,3 1,4 1,5 1,6 1,7 1,8 1,9 => even: 0.05 ~ 0.1, odd:  0.55 ~ 0.6
                // ..
                // 9,0 9,1 9,2 9,3 9,4 9,5 9,6 9,7 9,8 9,9 => even: 0.45 ~ 0.5, odd:  0.95 ~ 1.0
                turns: Tween(
                  begin: 0.0,
                  end: 0.25,
                ).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Interval(y * interval * half, (y + 1) * interval),
                  ).drive(CurveTween(curve: curve)),
                ),
                child: DecoratedBoxTransition(
                  decoration: _whiteDecoration,
                  child: Container(),
                ),
              );
            } else {
              return RotationTransition(
                turns: Tween(
                  begin: 0.0,
                  end: 0.25,
                ).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Interval(
                      init + y * interval * half,
                      init + (y + 1) * interval,
                    ),
                  ).drive(CurveTween(curve: curve)),
                ),
                child: DecoratedBoxTransition(
                  decoration: _blackDecoration,
                  child: Container(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
