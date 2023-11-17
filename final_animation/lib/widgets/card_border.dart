import 'package:flutter/material.dart';

class CardBorder extends StatelessWidget {
  const CardBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
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
    );
  }
}
