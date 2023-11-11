import 'dart:ui';

import 'package:final_project/models/mood_model.dart';
import 'package:final_project/view_models/mood_view_model.dart';
import 'package:final_project/views/mood_detail_screen.dart';
import 'package:final_project/widgets/avatar.dart';
import 'package:final_project/widgets/mood_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/gaps.dart';
import '../widgets/mood_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = 'home';
  static const routeURL = '/home';
  final void Function(int) onTap;
  const HomeScreen({Key? key, required this.onTap}) : super(key: key);

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
    super.dispose();
  }

  void _onTap(
    MoodModel mood,
  ) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: MoodDetailScreen(
              mood: mood,
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
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: ref.watch(moodProvider).when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
              child: Text("No Moods"),
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
                        "assets/${data[_currentPage].moodType.id}.jpg",
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
                  final mood = data[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Avatar(
                            email: mood.creatorEmail,
                            uid: mood.creatorId,
                            size: 20,
                            hasAvatar: mood.hasAvatar,
                          ),
                          Gaps.h12,
                          Text(
                            mood.creatorEmail,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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
                            onTap: () => _onTap(mood),
                            child: Hero(
                              tag: mood.id,
                              child: Transform.scale(
                                scale: scale,
                                child: MoodCard(
                                  moodId: mood.moodType.id,
                                  payload: mood.payload,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Gaps.v12,
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0, left: 6),
                        child: MoodBottomBar(
                          mood: mood,
                        ),
                      ),
                      Gaps.v24,
                      Text(
                        mood.moodType.emoji,
                        style: const TextStyle(
                          fontSize: 48,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        mood.moodType.id.toUpperCase(),
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
          return Text(error.toString());
        },
      ),
    );
  }
}
