import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threads/repos/user_repo.dart';

import '../constants/gaps.dart';
import '../view_models/settings_view_model.dart';
import '../widgets/search_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const String routeName = 'search';
  static const String routeURL = '/search';

  @override
  State<StatefulWidget> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final isDark = context.watch<SettingsViewModel>().darkMode;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Search",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Gaps.v12,
            CupertinoTextField(
              controller: _searchController,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              prefix: Icon(
                Icons.search,
                color: isDark ? Colors.white : Colors.black,
              ),
              placeholder: "Search",
            ),
            Gaps.v12,
            FutureBuilder(
              future: UserRepository.searchUsers(_searchController.value.text),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Flexible(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => SearchTile(
                        userModel: snapshot.data![index],
                      ),
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (context, index) => Divider(
                        color: isDark
                            ? Colors.grey.shade900
                            : Colors.grey.shade200,
                        indent: 72,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
