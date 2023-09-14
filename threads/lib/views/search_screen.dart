import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import '../constants/gaps.dart';
import '../view_models/settings_view_model.dart';
import '../view_models/user_view_models.dart';
import '../widgets/search_tile.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const String routeName = 'search';
  static const String routeURL = '/search';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<SearchScreen> {
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
              prefix: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              placeholder: "Search",
            ),
            Gaps.v12,
            ref.watch(usersProvider(_searchController.value.text)).when(
                  data: (data) => Flexible(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => SearchTile(
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
                  error: (error, stackTrace) => Text(error.toString()),
                ),
          ],
        ),
      ),
    );
  }
}
