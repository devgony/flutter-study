import 'dart:io';

import 'package:camera/camera.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/views/camera_screen.dart';

import '../constants/sizes.dart';
import '../utils.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  XFile? _picture;
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
            // mainAxisSize: MainAxisSize.min,
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
                          final picture = await Navigator.push(
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
                                Image.file(
                                  File(_picture!.path),
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
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
              Text(
                "Post",
                style: TextStyle(
                  color: Colors.blue
                      .withOpacity(_textController.text.isEmpty ? 0.3 : 1),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}