import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  final double score;

  const Stars({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 1; i <= 5; i++)
          Icon(
            i <= score ? Icons.star : Icons.star_border,
            color: Colors.yellow,
          ),
      ],
    );
  }
}
