import 'package:flutter/material.dart';

class MinButton extends StatelessWidget {
  final int min;
  final bool selected;
  final VoidCallback onPressed;

  const MinButton({
    Key? key,
    required this.min,
    required this.selected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          fixedSize: const Size(84, 48),
          backgroundColor: selected ? Colors.white : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              width: 1,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        child: Text(
          min < 10 ? "0${min.toString()}" : min.toString(),
          style: TextStyle(
            color: selected ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
