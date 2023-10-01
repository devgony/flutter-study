import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

double getScreenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

String elapsedString(Timestamp createdAt) {
  final now = DateTime.now();
  // final createdAt = createdAt.toDate();
  final date = createdAt.toDate();
  final difference = now.difference(date);

  String elapsed;
  if (difference.inMinutes < 60) {
    elapsed = '${difference.inMinutes} minutes';
  } else if (difference.inHours < 24) {
    elapsed = '${difference.inHours} hours';
  } else if (difference.inDays < 7) {
    elapsed = '${difference.inDays} days';
  } else {
    elapsed = DateFormat('yyyy-MM-dd').format(date);
  }

  return '$elapsed ago';
}
