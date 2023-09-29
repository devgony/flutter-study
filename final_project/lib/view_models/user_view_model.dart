import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../repositories/authentication_repository.dart';
import '../repositories/user_repositories.dart';

class UsersViewModel extends AsyncNotifier<void> {
  late final UserRepository _userRepository;

  @override
  Future<void> build() async {
    _userRepository = ref.read(userRepository);
  }

  Future<List<UserModel>> searchUsers(String keyword) async {
    final userId = ref.read(authRepository).user!.uid;
    return _userRepository.searchUsers(userId, keyword);
  }

  Future<void> createUser(
    UserCredential userCredential,
  ) async {
    final UserModel user = UserModel(
      // profileImage: "",
      uid: userCredential.user!.uid,
      userName: userCredential.user!.email!,
    );

    await _userRepository.createUser(user);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, void>(
  () => UsersViewModel(),
);
