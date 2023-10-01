import 'package:final_project/models/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/authentication_repository.dart';
import '../repositories/post_repositories.dart';

class PostViewModel extends StreamNotifier<List<PostModel>> {
  final PostRepository _postRepository = PostRepository();
  AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  // List<PostModel> _posts = [];
  // List<PostModel> get posts => _posts;

  Future<void> createPost(String payload, String mood) async {
    await _postRepository.createPost(payload, mood);
  }

  Future<void> deletePost(String id) async {
    await _postRepository.deletePost(id);
  }

  Stream<List<PostModel>> getPosts() {
    return _postRepository.getPosts(_authenticationRepository.user!.uid);
  }

  likePost(String id) {
    _postRepository.likePost(id, _authenticationRepository.user!.uid);
  }

  dislikePost(String id) {
    _postRepository.dislikePost(id, _authenticationRepository.user!.uid);
  }

  @override
  Stream<List<PostModel>> build() {
    _authenticationRepository = ref.read(authRepository);
    return getPosts();
  }

  // Future<void> searchPosts(String PostId, String keyword) async {
  // _posts = await _postRepository.searchPosts(PostId, keyword);
  // notifyListeners();
  // }

  // Future<String> uploadThread(
  // File file,
  // String authorId,
  // ) async {
  // final fileName =
  // "/threads/$authorId/${DateTime.now().millisecondsSinceEpoch.toString()}";
  // final ref = _postRepository.storage.ref().child(fileName);
  // await ref.putFile(file);
//
  // return fileName;
  // }
}

final postProvider = StreamNotifierProvider<PostViewModel, List<PostModel>>(
  () => PostViewModel(),
);
