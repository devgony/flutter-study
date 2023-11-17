import 'package:final_animation/widgets/card_bottom.dart';
import 'package:final_animation/widgets/pokeball.dart';
import 'package:final_animation/widgets/stars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/gaps.dart';
import '../repositories/pokemon_repository.dart';
import 'card_border.dart';

class CardPageView extends StatelessWidget {
  final PageController cardPageController;
  final bool onDetail;
  final ValueListenable<double> scroll;
  final void Function(int) onPageChanged;
  final VoidCallback toggleDetail;

  const CardPageView({
    super.key,
    required this.cardPageController,
    required this.onDetail,
    required this.scroll,
    required this.onPageChanged,
    required this.toggleDetail,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: onPageChanged,
      controller: cardPageController,
      itemCount: pokemons.length,
      scrollDirection: Axis.horizontal,
      physics: onDetail
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: scroll,
              builder: (context, scroll, child) {
                final difference = (scroll - index).abs();
                final scale = 1 - (difference * 0.1);
                return GestureDetector(
                  onVerticalDragEnd: (_) => toggleDetail(),
                  child: Transform.scale(
                    scale: scale,
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: toggleDetail,
                          icon: FaIcon(
                            onDetail
                                ? FontAwesomeIcons.chevronDown
                                : FontAwesomeIcons.chevronUp,
                            color: Colors.white,
                          ),
                        ),
                        Gaps.v24,
                        Stack(
                          children: [
                            const CardBorder(),
                            CardBottom(index: index),
                            const Pokeball(),
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
            Gaps.v12,
            const Stars(),
          ],
        );
      },
    );
  }
}
