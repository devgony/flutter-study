import 'package:final_animation/models/pokemon_model.dart';

String imagePath(int id) => "assets/images/$id.png";
String coverPath(int id) => "assets/covers/$id.jpg";

final List<Map<String, dynamic>> data = [
  {
    "name": "Venusaur Gigantamax",
    "description1":
        "In battle, this Pokémon swings around two thick vines. If these vines slammed into a 10-story building, they could easily topple it.",
    "description2":
        "Huge amounts of pollen burst from it with the force of a volcanic eruption. Breathing in too much of the pollen can cause fainting.",
    "types": ["Grass", "Poison"],
    "weaknesses": ["Fire", "Flying", "Ice", "Psychic"],
    "caterogy": "Seed",
    "height": "24.0 m〜",
    "weight": "???.? kg",
    "gender": "both",
    "ability": "Overgrow"
  },
  {
    "name": "Charizard Gigantamax",
    "description1":
        "This colossal, flame-winged figure of a Charizard was brought about by Gigantamax energy.",
    "description2":
        "The flame inside its body burns hotter than 3,600 degrees Fahrenheit. When Charizard roars, that temperature climbs even higher.",
    "types": ["Fire", "Flying"],
    "weaknesses": ["Electric", "Rock", "Water"],
    "caterogy": "Flame",
    "height": "28.0 m〜",
    "weight": "???.? kg",
    "gender": "both",
    "ability": "Blaze"
  },
  {
    "name": "Blastoise Gigantamax",
    "description1":
        "It’s not very good at precision shooting. When attacking, it just fires its 31 cannons over and over and over.",
    "description2":
        "Water fired from this Pokémon’s central main cannon has enough power to blast a hole into a mountain.",
    "types": ["Water"],
    "weaknesses": ["Electric", "Grass"],
    "caterogy": "Shellfish",
    "height": "25.0 m〜",
    "weight": "???.? kg",
    "gender": "both",
    "ability": "Torrent"
  },
  {
    "name": "Pikachu Gigantamax",
    "description1":
        "Its Gigantamax power expanded, forming its supersized body and towering tail.",
    "description2":
        "When it smashes its opponents with its bolt- shaped tail, it delivers a surge of electricity equivalent to a lightning strike.",
    "types": ["Electric"],
    "weaknesses": ["Ground"],
    "caterogy": "Mouse",
    "height": "21.0 m〜",
    "weight": "???.? kg",
    "gender": "both",
    "ability": "Static"
  }
];

final pokemons = data
    .asMap()
    .entries
    .map(
      (e) => Pokemon.fromMap(e.key, e.value),
    )
    .toList();

// final List<Pokemon> pokemons = [
//   [
//     "Venusaur Gigantamax",
//     "In battle, this Pokémon swings around two thick vines. If these vines slammed into a 10-story building, they could easily topple it.",
//     "Huge amounts of pollen burst from it with the force of a volcanic eruption. Breathing in too much of the pollen can cause fainting.",
//   ],
//   [
//     "Charizard Gigantamax",
//     "This colossal, flame-winged figure of a Charizard was brought about by Gigantamax energy.",
//     "The flame inside its body burns hotter than 3,600 degrees Fahrenheit. When Charizard roars, that temperature climbs even higher.",
//   ],
//   [
//     "Blastoise Gigantamax",
//     "It’s not very good at precision shooting. When attacking, it just fires its 31 cannons over and over and over.",
//     "Water fired from this Pokémon’s central main cannon has enough power to blast a hole into a mountain."
//   ]
// ]
//     .asMap()
//     .entries
//     .map(
//       (e) => Pokemon(
//         id: e.key,
//         name: e.value[0],
//         image: imagePath(e.key),
//         cover: coverPath(e.key),
//         description1: e.value[1],
//         description2: e.value[2],
//       ),
//     )
//     .toList();
