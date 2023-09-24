import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/utils.dart';

import '../constants/gaps.dart';
import '../models/user_model.dart';
import '../view_models/settings_view_model.dart';

class SearchTile extends ConsumerStatefulWidget {
  final UserModel userModel;
  const SearchTile({Key? key, required this.userModel}) : super(key: key);

  @override
  ConsumerState<SearchTile> createState() => _SearchTileState();
}

class _SearchTileState extends ConsumerState<SearchTile> {
  bool _following = false;
  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(settingsProvider).darkMode;
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          getImage(),
        ),
      ),
      title: Text(widget.userModel.uid),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.userModel.userName,
          ),
          Gaps.v12,
          Text(
            "${widget.userModel.followers} followers",
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            _following = !_following;
          });
        },
        child: Container(
          width: 80,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _following
                ? isDark
                    ? Colors.white
                    : Colors.black
                : Colors.transparent,
            border: const Border(
              top: BorderSide(
                color: Colors.grey,
              ),
              bottom: BorderSide(
                color: Colors.grey,
              ),
              left: BorderSide(
                color: Colors.grey,
              ),
              right: BorderSide(
                color: Colors.grey,
              ),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: _following
              ? Text(
                  'Following',
                  style: TextStyle(
                    backgroundColor: isDark ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(
                  'Follow',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
        ),
      ),
    );
  }
}
