import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String payload;
  final FaIcon? icon;
  final CustomPaint? customPaint;
  final Function? onTap;
  final bool isDark;
  final bool active;
  final bool isLoading;

  const AuthButton({
    super.key,
    required this.payload,
    this.icon,
    this.onTap,
    this.customPaint,
    this.isDark = false,
    this.active = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final double opacity = active ? 1 : 0.5;
    return GestureDetector(
      onTap: () => onTap == null ? () => {} : onTap!(context),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: (isDark ? Colors.black : Colors.white).withOpacity(opacity),
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
              isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      payload,
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w800,
                        color: (isDark ? Colors.white : Colors.black)
                            .withOpacity(opacity),
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
