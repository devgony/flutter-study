import 'package:final_animation/screens/pokemon_detail_screen.dart';
import 'package:final_animation/widgets/background_switcher.dart';
import 'package:final_animation/widgets/card_page_view.dart';
import 'package:final_animation/widgets/pokemon_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  bool onDetail = false;

  final PageController _cardPageController = PageController(
    viewportFraction: 0.8,
  );
  final PageController _pokemonPageController = PageController(
    viewportFraction: 0.8,
  );
  final ValueNotifier<double> _scroll = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    _cardPageController.addListener(() {
      if (_cardPageController.page == null) return;
      _scroll.value = _cardPageController.page!;

      _pokemonPageController.animateTo(
        _cardPageController.position.pixels,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    _cardPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundSwitcher(currentPage: _currentPage),
          CardPageView(
            cardPageController: _cardPageController,
            onDetail: onDetail,
            scroll: _scroll,
            onPageChanged: (value) => setState(() => _currentPage = value),
            toggleDetail: () => setState(() => onDetail = !onDetail),
          ).animateY(onDetail: onDetail, begin: 0, end: 0.73),
          PokemonPageView(
            pokemonPageController: _pokemonPageController,
          ).animateY(onDetail: onDetail, begin: 0.45, end: 2.5, duration: 600),
          PokemonDetailScreen(
            index: _currentPage,
          ).animateY(onDetail: onDetail, begin: -1, end: 0)
        ],
      ),
    );
  }
}

extension _AnimateY on Widget {
  Animate animateY({
    required bool onDetail,
    required double begin,
    required double end,
    int duration = 500,
  }) {
    return animate(target: onDetail ? 1 : 0).slideY(
      begin: begin,
      end: end,
      duration: duration.milliseconds,
      curve: Curves.easeInCubic,
    );
  }
}
