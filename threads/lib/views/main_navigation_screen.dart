import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:threads/utils.dart';
import 'package:threads/views/home_screen.dart';
import 'package:threads/views/activity_screen.dart';
import 'package:threads/views/profile_screen.dart';
import 'package:threads/views/search_screen.dart';
import 'package:threads/views/write_screen.dart';

import '../../../constants/sizes.dart';
import '../view_models/settings_view_model.dart';
import '../widgets/nav_tab.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/';
  final String tab;
  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  ConsumerState<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  final List<String> _tabs = [
    "",
    "search",
    "xxxx",
    "activity",
    "profile",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  _onWriteTap() {
    final isDark = ref.watch(settingsProvider).darkMode;
    showModalBottomSheet(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
      context: context,
      builder: (context) => const WriteScreen(),
      constraints: BoxConstraints(
        maxHeight: getScreenHeight(context) * 0.9,
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(settingsProvider).darkMode;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const SearchScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const WriteScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const ActivityScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const ProfileScreen(tab: "like"),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: isDark ? Colors.black : Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + Sizes.size12,
          ),
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavTab(
                  text: "Home",
                  isSelected: _selectedIndex == 0,
                  icon: FontAwesomeIcons.house,
                  selectedIcon: FontAwesomeIcons.house,
                  onTap: () => _onTap(0),
                  selectedIndex: _selectedIndex,
                ),
                NavTab(
                  text: "Search",
                  isSelected: _selectedIndex == 1,
                  icon: FontAwesomeIcons.compass,
                  selectedIcon: FontAwesomeIcons.solidCompass,
                  onTap: () => _onTap(1),
                  selectedIndex: _selectedIndex,
                ),
                NavTab(
                  text: "Write",
                  isSelected: _selectedIndex == 2,
                  icon: FontAwesomeIcons.penToSquare,
                  selectedIcon: FontAwesomeIcons.solidPenToSquare,
                  onTap: () => _onWriteTap(),
                  selectedIndex: _selectedIndex,
                ),
                NavTab(
                  text: "Activity",
                  isSelected: _selectedIndex == 3,
                  icon: FontAwesomeIcons.heart,
                  selectedIcon: FontAwesomeIcons.solidHeart,
                  onTap: () => _onTap(3),
                  selectedIndex: _selectedIndex,
                ),
                NavTab(
                  text: "Profile",
                  isSelected: _selectedIndex == 4,
                  icon: FontAwesomeIcons.user,
                  selectedIcon: FontAwesomeIcons.solidUser,
                  onTap: () => _onTap(4),
                  selectedIndex: _selectedIndex,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
