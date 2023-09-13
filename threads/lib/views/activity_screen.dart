import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/utils.dart';
import 'package:threads/view_models/user_view_models.dart';

import '../constants/gaps.dart';
import '../widgets/activity_tile.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  static const String routeURL = '/activity';
  static const String routeName = 'activity';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = isDarkMode(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: DefaultTabController(
          initialIndex: 0,
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: false,
              title: const Text(
                "Activity",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              bottom: TabBar(
                padding: EdgeInsets.zero,
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: 3,
                ),
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                unselectedLabelColor: isDark ? Colors.white : Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 0,
                labelColor: isDark ? Colors.black : Colors.white,
                indicator: BoxDecoration(
                  color: isDark ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                ),
                isScrollable: true,
                tabs: ["All", "Replies", "Mentions", "Verified", "Movies"]
                    .map(
                      (e) => Tab(
                        height: 36,
                        child: Container(
                          width: 96,
                          decoration: BoxDecoration(
                            // color: Colors.grey.shade700,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(e),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            body: TabBarView(
              children: [
                Center(
                  child: Column(
                    children: [
                      Gaps.v16,
                      ref.watch(usersProvider("")).when(
                            data: (data) => Flexible(
                              child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) => ActivityTile(
                                  userModel: data[index],
                                ),
                                itemCount: data.length,
                                separatorBuilder: (context, index) => Divider(
                                  color: Colors.grey.shade300,
                                  indent: 72, // TODO: Fix this
                                ),
                              ),
                            ),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stackTrace) =>
                                Text(error.toString()),
                          ),
                    ],
                  ),
                ),
                const Center(
                  child: Text("Replies"),
                ),
                const Center(
                  child: Text("Mentions"),
                ),
                const Center(
                  child: Text("Verified"),
                ),
                const Center(
                  child: Text("Movies"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
