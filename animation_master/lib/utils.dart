import 'package:flutter/material.dart';

Color getColor(int index) {
  return () {
    final row = index ~/ 10;
    final column = index % 10;
    if (row % 2 == 0 && column % 2 == 0) {
      return Colors.orange;
    } else if (row % 2 == 0 && column % 2 == 1) {
      return Colors.red;
    } else if (row % 2 == 1 && column % 2 == 0) {
      return Colors.cyan;
    } else {
      return Colors.white;
    }
  }();
}
