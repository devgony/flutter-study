import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/view_models/settings_view_model.dart';

import '../view_models/user_view_models.dart';
import '../widgets/activity_tile.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(settingsProvider).darkMode;
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
            body: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: TabBarView(
                children: [
                  FutureBuilder(
                    future: ref.watch(usersProvider.notifier).searchUsers(""),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => ActivityTile(
                            userModel: snapshot.data![index],
                          ),
                          itemCount: snapshot.data!.length,
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey.shade300,
                            indent: 72,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return const CircularProgressIndicator();
                    },
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
      ),
    );
  }
}
