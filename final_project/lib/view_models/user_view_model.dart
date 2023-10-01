import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../repositories/authentication_repository.dart';
import '../repositories/user_repositories.dart';

class UsersViewModel extends AsyncNotifier<UserModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserModel> build() async {
    _usersRepository = ref.read(userRepository);
    _authenticationRepository = ref.read(authRepository);

    if (_authenticationRepository.isLoggedIn) {
      final profile =
          await _usersRepository.findUser(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserModel.fromJson(profile);
      }
    }
    return UserModel.empty();
  }

  Future<List<UserModel>> searchUsers(String keyword) async {
    final userId = ref.read(authRepository).user!.uid;
    return _usersRepository.searchUsers(userId, keyword);
  }

  Future<void> createUser(
    UserCredential userCredential,
  ) async {
    final UserModel user = UserModel(
      uid: userCredential.user!.uid,
      email: userCredential.user!.email!,
      hasAvatar: false,
    );

    await _usersRepository.createUser(user);
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith());
    await _usersRepository.updateUser(state.value!.uid, {"hasAvatar": true});
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserModel>(
  () => UsersViewModel(),
);
