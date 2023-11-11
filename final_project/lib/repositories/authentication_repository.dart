import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;

  Future<UserModel> me() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("users").doc(_firebaseAuth.currentUser!.uid).get();
    final user = snapshot.data()!;
    final List<String> likedMoods = List.castFrom<dynamic, String>(
      user["likedMoods"],
    );
    return UserModel.fromJson(
      {...user, "likedMoods": likedMoods},
    );
  }

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<UserCredential> emailSignUp(String email, String password) async {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

final authRepository = Provider((ref) => AuthenticationRepository());

final authState = StreamProvider((ref) {
  final repo = ref.read(authRepository);

  return repo.authStateChanges();
});
