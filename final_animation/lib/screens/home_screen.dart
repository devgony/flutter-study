import 'dart:ui';

import 'package:final_animation/screens/pokemon_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/gaps.dart';
import '../repositories/pokemon_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;

  bool onDetail = false;
  void goToDetail(DragEndDetails _) => setState(() => onDetail = true);
  void goToMain() {
    setState(() => onDetail = false);
  }

  final PageController _pageController = PageController(
    viewportFraction: 0.8,
  );
  final ValueNotifier<double> _scroll = ValueNotifier(0.0);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: 500.milliseconds,
            child: Container(
              key: ValueKey(_currentPage),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    pokemons[_currentPage].cover,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          PokemonDetailScreen(
            index: _currentPage,
            goToMain: goToMain,
          ).animate(target: onDetail ? 1 : 0).slideY(
                begin: -1,
                end: 0,
                duration: 500.milliseconds,
                curve: Curves.easeInOut,
              ),
          PageView.builder(
            onPageChanged: (value) => setState(() => _currentPage = value),
            controller: _pageController,
            itemCount: pokemons.length,
            scrollDirection: Axis.horizontal,
            physics: onDetail
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder(
                  valueListenable: _scroll,
                  builder: (context, scroll, child) {
                    final difference = (scroll - index).abs();
                    final scale = 1 - (difference * 0.1);
                    return GestureDetector(
                      onVerticalDragEnd: (_) =>
                          setState(() => onDetail = !onDetail),
                      child: Transform.scale(
                        scale: scale,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () =>
                                  setState(() => onDetail = !onDetail),
                              icon: FaIcon(
                                onDetail
                                    ? FontAwesomeIcons.chevronDown
                                    : FontAwesomeIcons.chevronUp,
                                color: Colors.white,
                              ),
                            ),
                            Gaps.v36,
                            Stack(
                              children: [
                                Container(
                                  height: 400,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue.shade800,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 8),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 250,
                                  ),
                                  height: 150,
                                  width: double.infinity,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 8),
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      pokemons[index].name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 400,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(pokemons[index].image),
                                    ),
                                  ),
                                )
                                    .animate(
                                      target: onDetail ? 1 : 0,
                                    )
                                    .slideY(
                                      begin: -0.3,
                                      end: 0,
                                      duration: 500.milliseconds,
                                      curve: Curves.easeInOut,
                                    ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Gaps.v24,
                Text(
                  pokemons[index].description1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                Gaps.v24,
                const Text(
                  "Official Rating",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            )
                .animate(
                  target: onDetail ? 1 : 0,
                )
                .slideY(
                  begin: 0,
                  end: 0.73,
                  duration: 500.milliseconds,
                  curve: Curves.easeInOut,
                ),
          )
        ],
      ),
    );
  }
}
