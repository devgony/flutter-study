import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/constants/breakpoints.dart';
import 'package:threads/views/settings_screen.dart';

import '../constants/gaps.dart';
import '../utils.dart';
import '../view_models/settings_view_model.dart';
import '../view_models/thread_view_model.dart';
import '../widgets/persistance_tab_bar.dart';
import '../widgets/thread.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final String tab;
  const ProfileScreen({Key? key, required this.tab}) : super(key: key);

  static const String routeURL = '/profile';
  static const String routeName = 'profile';

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(settingsProvider).darkMode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Icon(Icons.public),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Breakpoints.lg,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 176,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: FlexibleSpaceBar(
                        background: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Jane',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gaps.v4,
                                    Row(
                                      children: [
                                        const Text(
                                          'jane_mobbin',
                                          style: TextStyle(),
                                        ),
                                        Gaps.h4,
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          child: Text(
                                            'threads.net',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(getImage()),
                                  radius: 30,
                                )
                              ],
                            ),
                            Gaps.v4,
                            const Text('Plant enthusiast!'),
                            Gaps.v12,
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(getImage()),
                                  radius: 10,
                                ),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(getImage()),
                                  radius: 10,
                                ),
                                Gaps.h8,
                                const Text(
                                  '2 followers',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Gaps.v12,
                              ],
                            ),
                            Gaps.v12,
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: Colors.grey.shade400,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: Text(
                                      'Edit profile',
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Gaps.h12,
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: Colors.grey.shade400,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: Text(
                                      'Share profile',
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: PersistentTabBar(),
                    pinned: true,
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(getImage()),
                                ),
                                title: const Text('Jane'),
                                subtitle: const Text('jane_mobbin'),
                                trailing: const Icon(Icons.more_vert),
                              );
                            },
                          ),
                          ref.watch(threadProvider).when(
                                data: (data) => ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => Thread(
                                    thread: data[index],
                                  ),
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.grey.shade300,
                                    indent: 72,
                                  ),
                                  itemCount: data.length,
                                ),
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
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
