import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../constants/breakpoints.dart';
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
    // Navigator.of(context).push(
    // MaterialPageRoute(
    // builder: (context) => const SettingsScreen(),
    // ),
    // );
  }

  void _onEditPressed() {
    // Navigator.of(context).push(
    // MaterialPageRoute(
    // builder: (context) => const ProfileEditScreen(),
    // ),
    // );
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
                              IconButton(
                                onPressed: _onEditPressed,
                                icon: const FaIcon(
                                  FontAwesomeIcons.penToSquare,
                                  size: Sizes.size20,
                                ),
                              ),
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
                                  hasAvatar: data.hasAvatar,
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
                          GridView.builder(
                            itemCount: 20,
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: width < Breakpoints.md ? 3 : 5,
                              crossAxisSpacing: Sizes.size2,
                              mainAxisSpacing: Sizes.size2,
                              childAspectRatio: 9 / 14,
                            ),
                            itemBuilder: (context, index) => Column(
                              children: [
                                Stack(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 9 / 14,
                                      child: FadeInImage.assetNetwork(
                                        fit: BoxFit.cover,
                                        placeholder: "assets/placeholder.jpg",
                                        image:
                                            "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
                                      ),
                                    ),
                                    index == 0
                                        ? Positioned(
                                            top: Sizes.size4,
                                            left: Sizes.size4,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: Sizes.size4,
                                                vertical: Sizes.size2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(Sizes.size3),
                                                ),
                                              ),
                                              child: const Text(
                                                "Pinned",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    Positioned(
                                      bottom: Sizes.size4,
                                      left: Sizes.size4,
                                      child: Row(
                                        children: const [
                                          FaIcon(
                                            FontAwesomeIcons.circlePlay,
                                            size: Sizes.size20,
                                            color: Colors.white,
                                          ),
                                          Gaps.h8,
                                          Text(
                                            "4.1M",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Center(
                            child: Text('Page two'),
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
