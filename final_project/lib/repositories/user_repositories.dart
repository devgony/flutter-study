import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  updateUser(String userId, Map<String, dynamic> data) async {
    await _db.collection("users").doc(userId).update(data);
  }

  Future<void> createUser(UserModel user) async {
    await _db.collection("users").doc(user.uid).set(user.toJson());
  }

  findUser(String userId) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("users").doc(userId).get();
    return snapshot.data();
  }

  Future<List<UserModel>> searchUsers(String userId, String keyword) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .where("userName", isGreaterThanOrEqualTo: keyword)
        .where("userName", isLessThanOrEqualTo: '$keyword\uf8ff')
        .get();

    final List<UserModel> users =
        snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();

    return users;
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

  Future<void> uploadAvatar(File file, String fileName) async {
    final fileRef = _storage.ref().child("avatars/$fileName");
    await fileRef.putFile(file);
  }
}

final userRepository = Provider(
  (ref) => UserRepository(),
);
