import 'package:final_project/models/mood_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/authentication_repository.dart';
import '../repositories/mood_repositories.dart';

class MoodViewModel extends StreamNotifier<List<MoodModel>> {
  final MoodRepository _moodRepository = MoodRepository();
  AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  subscribeComments(String moodId) {
    return _moodRepository.subscribeComments(moodId);
  }

  Future<void> createMood(String payload, String mood) async {
    final hasAvatar = (await _authenticationRepository.me()).hasAvatar;
    await _moodRepository.createMood(
      payload: payload,
      moodType: mood,
      uid: _authenticationRepository.user!.uid,
      email: _authenticationRepository.user!.email!,
      hasAvatar: hasAvatar,
    );
  }

  Future<void> deleteMood(String id) async {
    await _moodRepository.deleteMood(id);
  }

  Stream<List<MoodModel>> subscribeMoods() {
    return _moodRepository.subscribeMoods(_authenticationRepository.user!.uid);
  }

  Stream<List<MoodModel>> subscribeMyMoods() {
    if (_authenticationRepository.user == null) {
      return const Stream.empty();
    }
    return _moodRepository
        .subscribeMyMoods(_authenticationRepository.user!.uid);
  }

  Stream<MoodModel> subscribeMood(String moodId) {
    return _moodRepository.subscribeMood(
      _authenticationRepository.user!.uid,
      moodId,
    );
  }

  likeMood(String id) {
    _moodRepository.likeMood(id, _authenticationRepository.user!.uid);
  }

  dislikeMood(String id) {
    _moodRepository.dislikeMood(id, _authenticationRepository.user!.uid);
  }

  addComment(String id, String payload) async {
    final hasAvatar = (await _authenticationRepository.me()).hasAvatar;
    _moodRepository.addComment(
      id,
      payload,
      _authenticationRepository.user!.uid,
      _authenticationRepository.user!.email!,
      hasAvatar,
    );
  }

  @override
  Stream<List<MoodModel>> build() {
    _authenticationRepository = ref.read(authRepository);
    return subscribeMoods();
  }
}

final moodProvider = StreamNotifierProvider<MoodViewModel, List<MoodModel>>(
  () => MoodViewModel(),
);
