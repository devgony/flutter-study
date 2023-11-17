import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../repositories/pokemon_repository.dart';

class BackgroundSwitcher extends StatelessWidget {
  final int currentPage;

  const BackgroundSwitcher({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: 500.milliseconds,
      child: Container(
        key: ValueKey(currentPage),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              pokemons[currentPage].cover,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
