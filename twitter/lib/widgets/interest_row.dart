import 'package:flutter/material.dart';
import 'package:twitter/widgets/interest_button.dart';

class InterestRow extends StatelessWidget {
  final void Function(
    String,
    List<String>,
  ) onTap;
  final List<String> interests;
  final List<String> selectedInterests;

  const InterestRow({
    super.key,
    required this.onTap,
    required this.interests,
    required this.selectedInterests,
  });

  bool _isSelected(String interest) {
    return selectedInterests.contains(interest);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.bottomCenter,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: interests.length,
        itemBuilder: (context, index) {
          final interest = interests[index];
          return GestureDetector(
            onTap: () => onTap(interest, selectedInterests),
            child: InterestButton(
              isSelected: _isSelected(interest),
              interest: interest,
            ),
          );
        },
      ),
    );
  }
}
