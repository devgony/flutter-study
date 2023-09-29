import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/post_model.dart';
import '../views/post_screen.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createPost(String payload, String emotion) async {
    final post = {
      "payload": payload,
      "emotion": emotion.toString(),
      "createdAt": FieldValue.serverTimestamp(),
    };
    await _db.collection("posts").add(post);
  }

  Future<void> deletePost(String id) async {
    await _db.collection("posts").doc(id).delete();
  }

  Stream<List<PostModel>> getPosts() => _db
      .collection("posts")
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map(
        (event) => event.docs.map(
          (doc) {
            return PostModel.fromJson({
              "id": doc.id,
              "payload": doc["payload"],
              "emotion": Emotion.from(doc["emotion"]),
              "createdAt": doc["createdAt"],
            });
          },
        ).toList(),
      );

  // Future<List<PostModel>> searchPosts(String PostId, String keyword) async {
  // final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
  // .instance
  // .collection("Posts")
  // .where("PostName", isGreaterThanOrEqualTo: keyword)
  // .where("PostName", isLessThanOrEqualTo: '$keyword\uf8ff')
  // .get();
//
  // final List<PostModel> Posts =
  // snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
//
  // return Posts;
  // }

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

final postRepository = Provider(
  (ref) => PostRepository(),
);
