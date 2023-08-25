import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TwitterIcon extends StatelessWidget {
  const TwitterIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      FontAwesomeIcons.twitter,
      color: Colors.blue,
      size: 32,
    );
  }
}
