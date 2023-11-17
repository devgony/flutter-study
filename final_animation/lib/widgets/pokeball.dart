import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Pokeball extends StatelessWidget {
  const Pokeball({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 200,
      right: 110,
      child: Center(
        child: const Image(
          height: 100,
          image: AssetImage(
            "assets/images/pokeball.png",
          ),
        )
            .animate(
              onPlay: (controller) => controller.repeat(
                period: 2.seconds,
              ),
            )
            .rotate(),
      ),
    );
  }
}
