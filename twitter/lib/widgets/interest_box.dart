import 'package:flutter/material.dart';

class InterestBox extends StatelessWidget {
  final bool isSelected;
  final String interest;
  const InterestBox({
    super.key,
    required this.isSelected,
    required this.interest,
  });

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey,
                width: 0.5,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  bottom: 8,
                  right: 30,
                ),
                child: Text(
                  interest,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          isSelected
              ? const Positioned(
                  top: 5,
                  right: 5,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 20,
                  ),
                )
              : const SizedBox(),
        ],
      );
}
