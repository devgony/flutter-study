import 'package:flutter/material.dart';

class InterestRow extends StatelessWidget {
  final Function onTap;
  final List<String> interests;
  final List<String> selectedCategories;

  const InterestRow({
    super.key,
    required this.onTap,
    required this.interests,
    required this.selectedCategories,
  });

  bool _isSelected(String category) {
    return selectedCategories.contains(category);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.bottomCenter,
      child: ListView.builder(
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: interests.length,
        itemBuilder: (context, index) {
          final category = interests[index];
          return GestureDetector(
            onTap: () {
              onTap(category);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _isSelected(category) ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(
                  color: _isSelected(category) ? Colors.blue : Colors.grey,
                  width: 0.5,
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 36.0,
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: _isSelected(category) ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
