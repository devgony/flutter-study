import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';

String getImage() {
  final random = Random();
  return 'https://picsum.photos/300/200?hash=${random.nextInt(10000)}';
}

double getScreenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

bool isDarkMode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;
