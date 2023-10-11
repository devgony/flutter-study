import 'dart:ui';

import 'package:final_animation/screens/pokemon_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../repositories/pokemon_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;

  bool _isExpanded = false;

  PageController _pageController = PageController(
    viewportFraction: 0.8,
  );
  final ValueNotifier<double> _scroll = ValueNotifier(0.0);

  // void _onTap(int imageIndex) {
  //   Navigator.push(
  //     context,
  //     PageRouteBuilder(
  //       fullscreenDialog: true,
  //       pageBuilder: (context, animation, secondaryAnimation) {
  //         return SlideTransition(
  //           position: animation.drive(
  //             Tween(
  //               begin: const Offset(0, 0.5),
  //               end: const Offset(0, 0),
  //             ).chain(
  //               CurveTween(curve: Curves.easeInOut),
  //             ),
  //           ),
  //           child: PokemonDetailScreen(
  //             index: imageIndex,
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

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
          PageView.builder(
            onPageChanged: (value) => setState(() => _currentPage = value),
            controller: _pageController,
            itemCount: pokemons.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Stack(
              children: [
                PokemonDetailScreen(
                  index: index,
                )
                    .animate(target: _isExpanded ? 1 : 0)
                    .slideY(
                      begin: -1,
                      end: 0,
                      duration: 500.milliseconds,
                      curve: Curves.easeInOut,
                    )
                    .callback(
                      callback: (_) => setState(
                        () => _pageController = PageController(
                          viewportFraction: 1,
                        ),
                      ),
                    ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _scroll,
                      builder: (context, scroll, child) {
                        final difference = (scroll - index).abs();
                        final scale = 1 - (difference * 0.1);
                        return GestureDetector(
                          onVerticalDragEnd: (_) => setState(() {
                            _isExpanded = !_isExpanded;
                          }),
                          child: Transform.scale(
                            scale: scale,
                            child: Container(
                              height: 400,
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
                                    pokemons[index].image,
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Text(
                      pokemons[index].name,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    Text(
                      pokemons[index].description1,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const Text(
                      "Official Rating",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ).animate(target: _isExpanded ? 1 : 0).slideY(
                      begin: 0,
                      end: 1,
                      duration: 500.milliseconds,
                      curve: Curves.easeInOut,
                    ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
