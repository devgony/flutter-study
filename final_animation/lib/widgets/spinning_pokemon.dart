import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../repositories/pokemon_repository.dart';

class SpinningPokemon extends StatelessWidget {
  final int index;

  const SpinningPokemon({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.scale(
          scale: 1.2,
          child: const Image(
            image: AssetImage('assets/images/detail_bg.png'),
          )
              .animate(
                onPlay: (controller) => controller.repeat(
                  period: 2.seconds,
                ),
              )
              .rotate(),
        ),
        Transform.scale(
          scale: 0.8,
          child: const Image(
            image: AssetImage('assets/images/circle_bg.png'),
          ),
        ),
        Image(image: AssetImage(pokemons[index].image)),
      ],
    );
  }
}
