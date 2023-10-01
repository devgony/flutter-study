import 'dart:ui';

import 'package:final_project/models/post_model.dart';
import 'package:final_project/view_models/post_view_model.dart';
import 'package:final_project/views/mood_detail_screen.dart';
import 'package:final_project/widgets/avatar.dart';
import 'package:final_project/widgets/post_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/gaps.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = 'home';
  static const routeURL = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
  );

  final ValueNotifier<double> _scroll = ValueNotifier(0.0);

  int _currentPage = 0;

  void _onPageChanged(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page == null) return;
      _scroll.value = _pageController.page!;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    // _scroll.dispose();
    super.dispose();
  }

  void _onTap(
    PostModel post,
  ) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: MoodDetailScreen(
              post: post,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home Screen'),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         ref.read(authRepository).signOut();
      //         context.go("/");
      //       },
      //       icon: const Icon(Icons.logout),
      //     ),
      //   ],
      // ),
      body: ref.watch(postProvider).when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
              child: Text("No Posts"),
            );
          }
          return Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Container(
                  key: ValueKey(_currentPage),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/${data[_currentPage].mood.id}.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 20,
                      sigmaY: 20,
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              PageView.builder(
                onPageChanged: _onPageChanged,
                controller: _pageController,
                itemCount: data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final post = data[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Avatar(
                            email: post.creatorEmail,
                            uid: post.creatorId,
                            size: 20,
                          ),
                          Gaps.h12,
                          Text(
                            post.creatorEmail,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Gaps.v12,
                      ValueListenableBuilder(
                        valueListenable: _scroll,
                        builder: (context, scroll, child) {
                          final difference = (scroll - index).abs();
                          final scale = 1 - (difference * 0.1);
                          return GestureDetector(
                            onTap: () => _onTap(post),
                            child: Hero(
                              tag: post.id,
                              child: Transform.scale(
                                scale: scale,
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  height: 350,
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
                                        "assets/${post.mood.id}.jpg",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    color: Colors.black.withOpacity(0.2),
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: Text(
                                        post.payload,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Gaps.v12,
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0, left: 6),
                        child: PostBottomBar(
                          post: post,
                        ),
                      ),
                      Gaps.v24,
                      Text(
                        post.mood.emoji,
                        style: const TextStyle(
                          fontSize: 48,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        post.mood.id.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          print(stackTrace.toString());
          return Text(error.toString());
        },
      ),
    );
  }
}
