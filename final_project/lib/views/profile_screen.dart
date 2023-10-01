import 'package:final_project/view_models/post_view_model.dart';
import 'package:final_project/views/settings_screen.dart';
import 'package:final_project/widgets/grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../constants/breakpoints.dart';
import '../models/post_model.dart';
import '../view_models/user_view_model.dart';
import '../widgets/avatar.dart';
import '../widgets/persistance_tab_bar.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final String tab;

  const ProfileScreen({
    super.key,
    required this.tab,
  });

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == "likes" ? 1 : 0,
                length: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: Breakpoints.lg,
                    ),
                    child: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          SliverAppBar(
                            // title: Text(data.name),
                            actions: [
                              // IconButton(
                              //   onPressed: _onEditPressed,
                              //   icon: const FaIcon(
                              //     FontAwesomeIcons.penToSquare,
                              //     size: Sizes.size20,
                              //   ),
                              // ),
                              IconButton(
                                onPressed: _onGearPressed,
                                icon: const FaIcon(
                                  FontAwesomeIcons.gear,
                                  size: Sizes.size20,
                                ),
                              )
                            ],
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                Gaps.v20,
                                Avatar(
                                  uid: data.uid,
                                  email: data.email,
                                ),
                                Gaps.v20,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data.email,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: Sizes.size18,
                                      ),
                                    ),
                                    Gaps.h5,
                                    FaIcon(
                                      FontAwesomeIcons.solidCircleCheck,
                                      size: Sizes.size16,
                                      color: Colors.blue.shade500,
                                    )
                                  ],
                                ),
                                Gaps.v24,
                              ],
                            ),
                          ),
                          SliverPersistentHeader(
                            delegate: PersistentTabBar(),
                            pinned: true,
                          ),
                        ];
                      },
                      body: TabBarView(
                        children: [
                          ref.watch(postProvider).when(
                                data: (
                                  data,
                                ) =>
                                    GridViewPosts(data: data, width: width / 3),
                                error: (
                                  error,
                                  stackTrace,
                                ) =>
                                    Center(
                                  child: Text(error.toString()),
                                ),
                                loading: () => const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                              ),
                          FutureBuilder(
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(snapshot.error.toString()),
                                );
                              }
                              if (snapshot.hasData) {
                                final data = snapshot.data as List<PostModel>;
                                return GridViewPosts(
                                  data: data,
                                  width: width / 3,
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            },
                            future:
                                ref.watch(usersProvider.notifier).likedPosts(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
