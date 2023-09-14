import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/models/user_model.dart';

import '../repos/user_repo.dart';

class UsersViewModel extends FamilyAsyncNotifier<List<UserModel>, String> {
  late final UserRepository _userRepository;

  @override
  Future<List<UserModel>> build(String arg) async {
    _userRepository = ref.read(userRepository);

    return _userRepository.searchUsers(arg);
  }
}

final usersProvider =
    AsyncNotifierProvider.family<UsersViewModel, List<UserModel>, String>(
  () => UsersViewModel(),
);
