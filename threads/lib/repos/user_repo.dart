import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createUser(UserModel user) async {
    await _db.collection("users").doc(user.uid).set(user.toJson());
  }

  Future<List<UserModel>> searchUsers(String keyword) async {
    final String jsonString = await rootBundle.loadString('assets/users.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    final data = jsonData.map((json) => UserModel.fromJson(json));

    if (keyword.isEmpty) return data.toList();

    return data.where(
      (user) {
        final nameLower = user.uid.toLowerCase();
        final keywordLower = keyword.toLowerCase();

        return nameLower.contains(keywordLower);
      },
    ).toList();
  }

  Future<String> uploadThread(
    File file,
    String authorId,
  ) async {
    final fileName =
        "/threads/$authorId/${DateTime.now().millisecondsSinceEpoch.toString()}";
    final ref = _storage.ref().child(fileName);
    await ref.putFile(file);

    return fileName;
  }
}

final userRepository = Provider(
  (ref) => UserRepository(),
);
