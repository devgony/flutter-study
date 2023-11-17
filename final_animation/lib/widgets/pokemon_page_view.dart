import 'package:flutter/widgets.dart';

import '../repositories/pokemon_repository.dart';

class PokemonPageView extends StatelessWidget {
  final PageController pokemonPageController;

  const PokemonPageView({
    super.key,
    required this.pokemonPageController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: pokemonPageController,
        itemCount: pokemons.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                pokemons[index].image,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
