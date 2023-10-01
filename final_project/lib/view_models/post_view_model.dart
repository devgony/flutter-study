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

  subscribeComments(String postId) {
    return _postRepository.subscribeComments(postId);
  }

  Future<void> createPost(String payload, String mood) async {
    final hasAvatar = (await _authenticationRepository.me()).hasAvatar;
    await _postRepository.createPost(
      payload: payload,
      mood: mood,
      uid: _authenticationRepository.user!.uid,
      email: _authenticationRepository.user!.email!,
      hasAvatar: hasAvatar,
    );
  }

  Future<void> deletePost(String id) async {
    await _postRepository.deletePost(id);
  }

  Stream<List<PostModel>> subscribePosts() {
    return _postRepository.subscribePosts(_authenticationRepository.user!.uid);
  }

  Stream<List<PostModel>> subscribeMyPosts() {
    if (_authenticationRepository.user == null) {
      return const Stream.empty();
    }
    return _postRepository
        .subscribeMyPosts(_authenticationRepository.user!.uid);
  }

  Stream<PostModel> subscribePost(String postId) {
    return _postRepository.subscribePost(
      _authenticationRepository.user!.uid,
      postId,
    );
  }

  likePost(String id) {
    _postRepository.likePost(id, _authenticationRepository.user!.uid);
  }

  dislikePost(String id) {
    _postRepository.dislikePost(id, _authenticationRepository.user!.uid);
  }

  addComment(String id, String payload) async {
    final hasAvatar = (await _authenticationRepository.me()).hasAvatar;
    _postRepository.addComment(
      id,
      payload,
      _authenticationRepository.user!.uid,
      _authenticationRepository.user!.email!,
      hasAvatar,
    );
  }

  @override
  Stream<List<PostModel>> build() {
    _authenticationRepository = ref.read(authRepository);
    return subscribePosts();
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
