import 'package:final_project/models/user_model.dart';
import 'package:final_project/repositories/authentication_repository.dart';
import 'package:final_project/view_models/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/sizes.dart';
import '../models/post_model.dart';
import 'avatar.dart';

class WriteScreen extends ConsumerStatefulWidget {
  final PostModel post;
  const WriteScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  ConsumerState<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {});
    });
  }

  // static const String routeURL = '/write';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        // color: Colors.grey.shade300,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: Sizes.size16),
              ),
            ),
          ),
          leadingWidth: 80,
          backgroundColor: Colors.transparent,
          title: const Text('Write comment'),
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(
              height: 24,
              thickness: 1,
            ),
          ),
        ),
        body: IntrinsicHeight(
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    FutureBuilder(
                      future: ref.read(authRepository).me(),
                      builder: (
                        context,
                        AsyncSnapshot<UserModel> snapshot,
                      ) {
                        if (snapshot.hasData) {
                          return Avatar(
                            email: ref.read(authRepository).user!.email!,
                            uid: ref.read(authRepository).user!.uid,
                            size: 20,
                            hasAvatar: snapshot.data!.hasAvatar,
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),

                    // Avatar(
                    //   email: ref.read(authRepository).user!.email!,
                    //   uid: ref.read(authRepository).user!.uid,
                    //   size: 20,
                    //   hasAvatar: ref.read(authRepository).me().hasAvatar,
                    // ),
                    Expanded(
                      child: VerticalDivider(
                        width: Sizes.size32,
                        thickness: 0.5,
                        color: Colors.grey.shade600,
                        indent: 5,
                        endIndent: 5,
                      ),
                    ),
                    Avatar(
                      email: widget.post.creatorEmail,
                      uid: widget.post.creatorId,
                      size: 15,
                      hasAvatar: widget.post.hasAvatar,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ref.read(authRepository).user!.email!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: "Start a comment...",
                        border: InputBorder.none,
                      ),
                      minLines: 5,
                      maxLines: null,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomSheet: BottomAppBar(
          // height: 64,
          elevation: 0,
          // color: Colors.transparent,
          // margin: const EdgeInsets.only(bottom: 24),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            // vertical: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Anyone can reply",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              GestureDetector(
                onTap: () {
                  if (_textController.text.isNotEmpty) {
                    ref.read(postProvider.notifier).addComment(
                          widget.post.id,
                          _textController.text,
                        );
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "Post",
                  style: TextStyle(
                    color: Colors.blue
                        .withOpacity(_textController.text.isEmpty ? 0.3 : 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
