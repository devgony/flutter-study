import 'package:flutter/material.dart';

class MoodCard extends StatelessWidget {
  final String moodId;
  final String payload;

  const MoodCard({
    super.key,
    required this.moodId,
    required this.payload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          )
        ],
        image: DecorationImage(
          image: AssetImage(
            "assets/$moodId.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        color: Colors.black.withOpacity(0.2),
        child: Material(
          type: MaterialType.transparency,
          child: Text(
            textAlign: TextAlign.center,
            payload,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
