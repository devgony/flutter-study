import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

String getImage() {
  final random = Random();
  return 'https://picsum.photos/300/200?hash=${random.nextInt(10000)}';
}

double getScreenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

bool isDarkMode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;

void showFirebaseErrorSnack(
  BuildContext context,
  Object? error,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      content: Text(
        (error as FirebaseException).message ?? "Something wen't wrong.",
      ),
    ),
  );
}

String toImageURL(String imageUrl) =>
    "https://firebasestorage.googleapis.com/v0/b/threads-henry.appspot.com/o/${imageUrl.substring(1).replaceAll("/", "%2F")}?alt=media";
