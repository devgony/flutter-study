import 'package:final_project/views/post_screen.dart';
import 'package:final_project/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/sizes.dart';
import '../view_models/settings_view_model.dart';
import '../widgets/nav_tab.dart';
import 'home_screen.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  static const String routeName = "mainNavigation";
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
  final List<String> _tabs = ["home", "post", "profile"];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
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
            child: HomeScreen(onTap: _onTap),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: PostScreen(onTap: _onTap),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: ProfileScreen(
              onTap: _onTap,
              tab: "",
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: isDark ? Colors.black : Colors.grey.shade100,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
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
                  text: "Post",
                  isSelected: _selectedIndex == 1,
                  icon: FontAwesomeIcons.penToSquare,
                  selectedIcon: FontAwesomeIcons.solidPenToSquare,
                  onTap: () => _onTap(1),
                  selectedIndex: _selectedIndex,
                ),
                NavTab(
                  text: "Profie",
                  isSelected: _selectedIndex == 2,
                  icon: FontAwesomeIcons.user,
                  selectedIcon: FontAwesomeIcons.solidUser,
                  onTap: () => _onTap(2),
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
