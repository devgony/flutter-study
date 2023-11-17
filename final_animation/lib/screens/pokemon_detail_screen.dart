import 'package:final_animation/constants/gaps.dart';
import 'package:flutter/material.dart';

import '../repositories/pokemon_repository.dart';
import '../widgets/spinning_pokemon.dart';
import '../widgets/type_container.dart';
import '../widgets/profile_row.dart';

class PokemonDetailScreen extends StatefulWidget {
  final int index;
  const PokemonDetailScreen({
    super.key,
    required this.index,
  });

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 80,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                pokemons[widget.index].name,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              SpinningPokemon(index: widget.index),
              Gaps.v12,
              const Text(
                "Type",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              Gaps.v12,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...pokemons[widget.index]
                      .types
                      .map(
                        (type) => TypeContainer(type: type),
                      )
                      .toList(),
                ],
              ),
              Gaps.v12,
              const Text(
                "Weakness",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              Gaps.v12,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...pokemons[widget.index]
                      .weaknesses
                      .map(
                        (type) => TypeContainer(type: type),
                      )
                      .toList(),
                ],
              ),
              Gaps.v12,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  pokemons[widget.index].description2,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              Gaps.v12,
              Container(
                height: 230,
                margin: const EdgeInsets.symmetric(horizontal: 32),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue.shade800,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Gaps.v12,
                    ProfileRow(
                      name1: "Height",
                      value1: pokemons[widget.index].height,
                      name2: "Category",
                      value2: pokemons[widget.index].caterogy,
                    ),
                    ProfileRow(
                      name1: "Weight",
                      value1: pokemons[widget.index].weight,
                      name2: "Gender",
                      value2: pokemons[widget.index].gender,
                    ),
                    ProfileRow(
                      name1: "Ability",
                      value1: pokemons[widget.index].ability,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
