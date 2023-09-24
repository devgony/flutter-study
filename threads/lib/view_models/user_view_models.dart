import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/models/user_model.dart';
import 'package:threads/repos/auth_repo.dart';

import '../repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<void> {
  late final UserRepository _repository;

  @override
  Future<void> build() async {
    _repository = ref.read(userRepository);
  }

  Future<List<UserModel>> searchUsers(String keyword) async {
    final userId = ref.read(authRepository).user!.uid;
    return _repository.searchUsers(userId, keyword);
  }

  Future<void> createUser(
    UserCredential userCredential,
  ) async {
    final UserModel user = UserModel(
      profileImage: "",
      uid: userCredential.user!.uid,
      userName: userCredential.user!.email!,
      followers: 0,
    );

    await _repository.createUser(user);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, void>(
  () => UsersViewModel(),
);
