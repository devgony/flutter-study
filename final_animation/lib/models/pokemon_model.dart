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
