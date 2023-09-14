import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:threads/widgets/border_white.dart';

import '../constants/gaps.dart';
import '../utils.dart';
import '../view_models/settings_view_model.dart';
import '../widgets/thread.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeURL = '/';
  static const String routeName = 'home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _showModal = false;

  void _onScroll() {
    if (_scrollController.offset > 100) {
      if (_showModal) return;
      setState(() {
        _showModal = true;
      });
    } else {
      setState(() {
        _showModal = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<SettingsViewModel>().darkMode;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 80,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: SvgPicture.asset(
                  'assets/thread.svg',
                  width: 32,
                  height: 32,
                  color: isDark ? Colors.white : Colors.black,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Stack(
                      children: [
                        Column(
                          children: const [
                            Thread(),
                            Gaps.v16,
                            Divider(
                              height: 0,
                              thickness: 1,
                            ),
                            Gaps.v16,
                          ],
                        ),
                      ],
                    );
                  },
                  childCount: 10,
                ),
              )
            ],
          ),
          if (_showModal)
            SafeArea(
              child: GestureDetector(
                onTap: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  width: 130,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  child: Stack(
                    children: [
                      ...List.generate(
                        4,
                        (index) => Positioned(
                          left: index * 20.0,
                          child: BorderWhite(
                            child: CircleAvatar(
                              foregroundImage: NetworkImage(
                                getImage(),
                              ),
                              radius: 14,
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 4 * 20.0,
                        child: BorderWhite(
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            radius: 14,
                            child: Icon(
                              Icons.arrow_upward,
                              size: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     height: 100,
          //     color: isDark ? Colors.black : Colors.white,
          //     child: const Center(
          //       child: Text('Modal'),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
