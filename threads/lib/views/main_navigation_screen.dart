import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/views/home_screen.dart';
import 'package:threads/views/like_screen.dart';
import 'package:threads/views/profile_screen.dart';
import 'package:threads/views/discover_screen.dart';
import 'package:threads/views/write_screen.dart';

import '../../../constants/sizes.dart';
import '../widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({
    super.key,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const WriteScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const LikeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const ProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
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
                  text: "Discover",
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
                  onTap: () => _onTap(2),
                  selectedIndex: _selectedIndex,
                ),
                NavTab(
                  text: "Like",
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
