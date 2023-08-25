import 'package:flutter/material.dart';

class InterestButton extends StatelessWidget {
  final bool isSelected;
  final String interest;
  const InterestButton({
    super.key,
    required this.isSelected,
    required this.interest,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey,
          width: 0.5,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 36.0,
      ),
      child: Text(
        interest,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
