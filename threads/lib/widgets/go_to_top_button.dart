import 'package:flutter/material.dart';
import '../utils.dart';
import 'border_white.dart';

class GoToTopButton extends StatelessWidget {
  const GoToTopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      width: 130,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          ...List.generate(
            4,
            (index) => Positioned(
              left: index * 20.0,
              child: BorderWhite(
                child: CircleAvatar(
                  foregroundImage: NetworkImage(
                    getImage(),
                  ),
                  radius: 14,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 4 * 20.0,
            child: BorderWhite(
              child: CircleAvatar(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                radius: 14,
                child: Icon(
                  Icons.arrow_upward,
                  size: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
