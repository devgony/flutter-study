import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threads/widgets/go_to_top_button.dart';
import 'package:threads/view_models/thread_view_model.dart';

import '../constants/gaps.dart';
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
    final isDark = ref.watch(settingsProvider).darkMode;
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
              ref.watch(threadProvider).when(
                data: (data) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Stack(
                          children: [
                            Column(
                              children: [
                                Thread(
                                  thread: data[index],
                                ),
                                Gaps.v16,
                                const Divider(
                                  height: 0,
                                  thickness: 1,
                                ),
                                Gaps.v16,
                              ],
                            ),
                          ],
                        );
                      },
                      childCount: data.length,
                    ),
                  );
                },
                loading: () {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                error: (e, s) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text("error: ${e.toString()}"),
                    ),
                  );
                },
              ),
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
                child: const GoToTopButton(),
              ),
            )
        ],
      ),
    );
  }
}
