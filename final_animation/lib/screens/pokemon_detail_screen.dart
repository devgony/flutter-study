import 'package:final_animation/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../repositories/pokemon_repository.dart';
import '../widgets/TypeContainer.dart';

class PokemonDetailScreen extends StatefulWidget {
  final int index;
  // final void Function() goToMain;
  const PokemonDetailScreen({
    super.key,
    required this.index,
    // required this.goToMain,
  });

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            Stack(
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
                Image(image: AssetImage(pokemons[widget.index].image)),
              ],
            ),
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
                // textAlign: TextAlign.center,
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
                  getRow(
                    "Height",
                    pokemons[widget.index].height,
                    "Category",
                    pokemons[widget.index].caterogy,
                  ),
                  getRow(
                    "Weight",
                    pokemons[widget.index].weight,
                    "Gender",
                    pokemons[widget.index].gender,
                  ),
                  getRow(
                    "Ability",
                    pokemons[widget.index].ability,
                    null,
                    null,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget getRow(
  String n1,
  String v1,
  String? n2,
  String? v2,
) =>
    Padding(
      padding: const EdgeInsets.only(left: 36, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  n1,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue.shade300,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  v1,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: (n2 != null && v2 != null)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        n2,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue.shade300,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      n2 == "Gender"
                          ? RichText(
                              text: TextSpan(
                                children: [
                                  const WidgetSpan(
                                    child: FaIcon(
                                      FontAwesomeIcons.mars,
                                      color: Colors.blue,
                                      size: 16,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: " / ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: FaIcon(
                                      FontAwesomeIcons.venus,
                                      color: Colors.pink.shade300,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              v2,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            )
                    ],
                  )
                : Container(),
          )
        ],
      ),
    );
