import 'dart:io';

import 'package:camera/camera.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:threads/view_models/thread_view_model.dart';
import 'package:threads/widgets/image_carousel.dart';

import '../constants/sizes.dart';
import '../utils.dart';
import '../widgets/source.dart';
import 'camera_screen.dart';

class WriteScreen extends ConsumerStatefulWidget {
  const WriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  List<XFile>? _picture;
  final _textController = TextEditingController();
  final faker = Faker();
  final profile = getImage();
  late String username;

  @override
  void initState() {
    username = faker.person.name();
    super.initState();
    _textController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
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
          title: const Text('New thread'),
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
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    CircleAvatar(
                      foregroundImage: NetworkImage(
                        profile,
                      ),
                      radius: 24,
                    ),
                    Expanded(
                      child: VerticalDivider(
                        width: Sizes.size32,
                        thickness: 0.5,
                        color: Colors.grey.shade600,
                        indent: 5,
                        endIndent: 5,
                      ),
                    ),
                    CircleAvatar(
                      foregroundImage: NetworkImage(
                        profile,
                      ),
                      radius: 12,
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
                      username,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: "Start a thread...",
                        border: InputBorder.none,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: GestureDetector(
                        onTap: () async {
                          final List<XFile> picture = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CameraScreen(),
                            ),
                          );
                          setState(() {
                            _picture = picture;
                          });
                        },
                        child: Icon(
                          FontAwesomeIcons.paperclip,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    _picture != null
                        ? Expanded(
                            child: Stack(
                              children: [
                                ImageCarousel(
                                  sources:
                                      _picture!.map(FileSource.new).toList(),
                                ),
                                Positioned(
                                  top: 5,
                                  left: 5,
                                  child: GestureDetector(
                                    onTap: () => setState(() {
                                      _picture = null;
                                    }),
                                    child: Icon(
                                      FontAwesomeIcons.solidCircleXmark,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomSheet: BottomAppBar(
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Anyone can reply",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              GestureDetector(
                onTap: () async {
                  await ref.read(threadProvider.notifier).uploadThread(
                        body: _textController.text,
                        files: _picture != null
                            ? _picture!.map((e) => File(e.path)).toList()
                            : null,
                      );

                  context.pop();
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
