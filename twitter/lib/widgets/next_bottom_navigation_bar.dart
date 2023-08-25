import 'package:flutter/material.dart';
import '../constants/sizes.dart';

class NextBottomNavigationBar extends StatelessWidget {
  final String payload;
  final bool isValid;
  final Widget? nextScreen;

  const NextBottomNavigationBar({
    super.key,
    required this.payload,
    required this.isValid,
    this.nextScreen,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(payload),
            GestureDetector(
              onTap: () {
                if (!isValid || nextScreen == null) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => nextScreen!,
                  ),
                );
              },
              child: Container(
                width: Sizes.size96,
                height: 47,
                decoration: BoxDecoration(
                  color: isValid ? Colors.black : Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
