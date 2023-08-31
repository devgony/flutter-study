import 'dart:math';

import 'package:flutter/widgets.dart';

String getImage() {
  final random = Random();
  return 'https://picsum.photos/300/200?hash=${random.nextInt(10000)}';
}

double getScreenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;
