import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/models/thread_model.dart';
import 'package:threads/repos/thread_repo.dart';

import '../repos/auth_repo.dart';
import '../repos/user_repo.dart';

class ThreadViewModel extends StreamNotifier<List<ThreadModel>> {
  late final UserRepository _repository;

  @override
  Stream<List<ThreadModel>> build() {
    _repository = ref.read(userRepository);

    return getThreads();
  }

  Stream<List<ThreadModel>> getThreads() {
    return ref.read(threadRepository).getThreads();
  }

  Future<void> uploadThread({
    required String body,
    required List<File>? files,
  }) async {
    state = const AsyncValue.loading();
    final authorId = ref.read(authRepository).user!.uid;
    state = await AsyncValue.guard(
      () async {
        final imageUrl = files != null
            ? await Future.wait(
                files.map((file) async {
                  return await _repository.uploadThread(file, authorId);
                }),
              )
            : null;
        await ref
            .read(threadRepository)
            .createThread(authorId: authorId, body: body, imageUrls: imageUrl);

        throw ("todo");
      },
    );
  }
}

final threadProvider =
    StreamNotifierProvider<ThreadViewModel, List<ThreadModel>>(
  () => ThreadViewModel(),
);
