import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon? icon;
  final CustomPaint? customPaint;
  final Function? onTap;
  final bool isDark;

  const AuthButton({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
    this.customPaint,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap == null ? () => {} : onTap!(context),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: isDark ? Colors.black : Colors.white,
            border: Border.all(
              color: Colors.grey.shade300,
              width: Sizes.size2,
            ),
            borderRadius: BorderRadius.circular(
              Sizes.size36,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: icon ?? customPaint,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
