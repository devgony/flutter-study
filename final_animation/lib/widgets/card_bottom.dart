import 'package:final_animation/widgets/type_container.dart';
import 'package:flutter/material.dart';

import '../constants/gaps.dart';
import '../repositories/pokemon_repository.dart';

class CardBottom extends StatelessWidget {
  final int index;

  const CardBottom({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 250,
      ),
      height: 150,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gaps.v24,
          Text(
            pokemons[index].name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          Gaps.v8,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...pokemons[index]
                  .types
                  .map(
                    (type) => TypeContainer(type: type),
                  )
                  .toList(),
            ],
          )
        ],
      ),
    );
  }
}
