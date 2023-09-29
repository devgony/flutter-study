import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/post_model.dart';
import '../view_models/post_view_model.dart';

class PostScreen extends ConsumerStatefulWidget {
  static const routeName = 'post';
  static const routeURL = '/post';
  const PostScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final _textController = TextEditingController();
  Emotion? _emotion;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("How do you feel?"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 200,
              child: TextField(
                // expands: true,
                controller: _textController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                minLines: 5,
                decoration: const InputDecoration(
                  // contentPadding: EdgeInsets.only(
                  //   bottom: 200,
                  // ),
                  border: OutlineInputBorder(),
                  // labelText: 'Enter your username',
                  hintText: "Write it down here...",
                ),
              ),
            ),
          ),
          const Text("What's on your mind?"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: Emotion.values
                .map(
                  (e) => IconButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        _emotion?.id == e.id ? Colors.red : Colors.white,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _emotion = e;
                      });
                    },
                    icon: Text(e.emoji),
                  ),
                )
                .toList(),
          ),
          ElevatedButton(
            onPressed: () {
              if (_textController.text.isEmpty || _emotion == null) {
                return;
              }

              ref
                  .read(postProvider.notifier)
                  .createPost(_textController.text, _emotion!.id);
            },
            child: const Text("Post"),
          )
        ],
      ),
    );
  }
}
