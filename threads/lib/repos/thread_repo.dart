import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/models/thread_model.dart';

class ThreadRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadThread(
    String fileName,
    File file,
  ) async {
    final ref = _storage.ref().child("threads/$fileName");
    await ref.putFile(file);
  }

  Future<void> createThread({
    required String authorId,
    required String body,
    required List<String>? imageUrls,
  }) async {
    try {
      await _db.collection("threads").add({
        "authorId": authorId,
        "body": body,
        if (imageUrls != null) ...{"imageUrls": imageUrls},
        "createdAt": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<List<ThreadModel>> getThreads() {
    return _db
        .collection("threads")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map((doc) => ThreadModel.fromJson(doc.data()))
              .toList(),
        );
  }
}

final threadRepository = Provider((ref) => ThreadRepository());
