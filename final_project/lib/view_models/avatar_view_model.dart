import 'dart:async';
import 'dart:io';

import 'package:final_project/repositories/authentication_repository.dart';
import 'package:final_project/view_models/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/user_repositories.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(userRepository);
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();
    final fileName = ref.read(authRepository).user!.uid;
    state = await AsyncValue.guard(
      () async {
        await _repository.uploadAvatar(file, fileName);
        await ref.read(usersProvider.notifier).onAvatarUpload();
      },
    );
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(
  () => AvatarViewModel(),
);
