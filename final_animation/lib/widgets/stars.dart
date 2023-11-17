import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';

const stateMachine1 = "State Machine 1";

class Stars extends StatelessWidget {
  const Stars({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50,
      child: SingleChildScrollView(
        child: SizedBox(
          height: 300,
          child: RiveAnimation.asset(
            "assets/animations/stars-animation.riv",
            artboard: "New Artboard",
            stateMachines: [stateMachine1],
          ),
        ),
      ),
    );
  }
}
