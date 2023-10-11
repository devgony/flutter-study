import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../repositories/pokemon_repository.dart';

class PokemonDetailScreen extends StatefulWidget {
  final int index;
  const PokemonDetailScreen({super.key, required this.index});

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          pokemons[widget.index].name,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        Stack(
          children: [
            Transform.scale(
              scale: 1.2,
              child:
                  const Image(image: AssetImage('assets/images/detail_bg.png'))
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
            Image(image: AssetImage(pokemons[widget.index].image)),
          ],
        ),
      ],
    );
  }
}
