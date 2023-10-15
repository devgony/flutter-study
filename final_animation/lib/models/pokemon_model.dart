import 'package:flutter/painting.dart';

class Pokemon {
  final int id;
  final String name;
  final String image;
  final String cover;
  final String description1;
  final String description2;
  final String height;
  final String caterogy;
  final String weight;
  final String gender;
  final String ability;
  final List<String> types;
  final List<String> weaknesses;

  const Pokemon({
    required this.id,
    required this.name,
    required this.image,
    required this.cover,
    required this.description1,
    required this.description2,
    required this.height,
    required this.caterogy,
    required this.weight,
    required this.gender,
    required this.ability,
    required this.types,
    required this.weaknesses,
  });

  factory Pokemon.fromMap(int id, Map<String, dynamic> map) {
    return Pokemon(
      id: id,
      name: map['name'],
      image: "assets/images/$id.png",
      cover: "assets/covers/$id.jpg",
      description1: map['description1'],
      description2: map['description2'],
      height: map['height'],
      caterogy: map['caterogy'],
      weight: map['weight'],
      gender: map['gender'],
      ability: map['ability'],
      types: List<String>.from(map['types']),
      weaknesses: List<String>.from(map['weaknesses']),
    );
  }
}

Color getColorFromType(String color) => Color((color) {
      if (color == "Grass") return 0xFF8BBE8A;
      if (color == "Poison") return 0xFF9F6E97;
      if (color == "Fire") return 0xFFFB6C6C;
      if (color == "Flying") return 0xFF8FA8DD;
      if (color == "Water") return 0xFF56AEFF;
      if (color == "Electric") return 0xFFF2CB55;
      if (color == "Rock") return 0xFFD4C294;
      if (color == "Ground") return 0xFFE3C969;
      if (color == "Ice") return 0xFF91D8DF;
      if (color == "Psychic") return 0xFFF7798C;
      if (color == "Fairy") return 0xFFEEB0FA;
      return 0xFF8BBE8A;
    }(color));
