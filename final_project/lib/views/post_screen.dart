import 'package:final_project/constants/gaps.dart';
import 'package:final_project/widgets/fire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';

import '../models/mood_model.dart';
import '../view_models/mood_view_model.dart';

class PostScreen extends ConsumerStatefulWidget {
  static const routeName = 'post';
  static const routeURL = '/post';
  final void Function(int) onTap;
  const PostScreen({Key? key, required this.onTap}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final _textController = TextEditingController();
  MoodType _mood = MoodType.love;
  final _scrollController = FixedExtentScrollController(initialItem: 2);

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Fire(size: 50),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("How do you feel?"),
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
              child: Material(
                type: MaterialType.transparency,
                child: TextField(
                  controller: _textController,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 15,
                  minLines: 10,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write down here...",
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade100,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Gaps.v12,
          const Text("What's on your mind?"),
          SizedBox(
            height: 150,
            child: ListWheelScrollViewX(
              controller: _scrollController,
              itemExtent: 100,
              diameterRatio: 1.5,
              useMagnifier: true,
              magnification: 1.3,
              scrollDirection: Axis.horizontal,
              children: MoodType.values
                  .map(
                    (e) => IconButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          _mood.id == e.id ? Colors.red.shade400 : Colors.white,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      onPressed: null,
                      icon: Text(
                        e.emoji,
                        style: const TextStyle(fontSize: 48),
                      ),
                    ),
                  )
                  .toList(),
              onSelectedItemChanged: (index) => setState(() {
                _mood = MoodType.values[index];
              }),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red.shade400),
            ),
            onPressed: () {
              if (_textController.text.isEmpty) {
                return;
              }

              ref
                  .read(moodProvider.notifier)
                  .createMood(_textController.text, _mood.id);

              _textController.clear();
              _scrollController.jumpToItem(2);
              setState(() {});

              widget.onTap(0);
            },
            child: const Text(
              "Post",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
