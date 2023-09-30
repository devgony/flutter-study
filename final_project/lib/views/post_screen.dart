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
  Mood _mood = Mood.happy;

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
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: SizedBox(
          //     height: 200,
          //     child: TextField(
          //       // expands: true,
          //       controller: _textController,
          //       keyboardType: TextInputType.multiline,
          //       maxLines: 5,
          //       minLines: 5,
          //       decoration: const InputDecoration(
          //         // contentPadding: EdgeInsets.only(
          //         //   bottom: 200,
          //         // ),
          //         border: OutlineInputBorder(),
          //         // labelText: 'Enter your username',
          //         hintText: "Write it down here...",
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            height: 350,
            width: 350,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                )
              ],
              image: DecorationImage(
                image: AssetImage(
                  "assets/${_mood.id}.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.black.withOpacity(0.2),
              child: const Material(
                type: MaterialType.transparency,
                child: TextField(
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 15,
                  minLines: 10,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write it down here...",
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Text("What's on your mind?"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: Mood.values
                .map(
                  (e) => IconButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        _mood.id == e.id ? Colors.red : Colors.white,
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
                        _mood = e;
                      });
                    },
                    icon: Text(e.emoji),
                  ),
                )
                .toList(),
          ),
          ElevatedButton(
            onPressed: () {
              if (_textController.text.isEmpty) {
                return;
              }

              ref
                  .read(postProvider.notifier)
                  .createPost(_textController.text, _mood.id);
            },
            child: const Text("Post"),
          )
        ],
      ),
    );
  }
}
