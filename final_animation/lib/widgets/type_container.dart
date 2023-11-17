import 'package:flutter/material.dart';

import '../models/pokemon_model.dart';

class TypeContainer extends StatelessWidget {
  final String type;
  const TypeContainer({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 16,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: getColorFromType(
          type,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        type,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
