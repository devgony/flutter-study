import 'package:flutter/material.dart';

import 'dark_mode_config.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final isDark = darkModeConfig.value;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
        // labelPadding: const EdgeInsets.symmetric(
        //   vertical: Sizes.size10,
        // ),
        tabs: const [
          Center(child: Text('Threads')),
          Center(child: Text('Replies')),
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: Sizes.size20,
          //   ),
          //   child: Icon(Icons.grid_4x4_rounded),
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: Sizes.size20,
          //   ),
          //   child: FaIcon(FontAwesomeIcons.heart),
          // ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
