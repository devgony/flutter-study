import 'package:flutter/material.dart';

import '../constants/gaps.dart';
import '../models/user_model.dart';
import '../utils.dart';

class SearchTile extends StatefulWidget {
  final UserModel userModel;
  const SearchTile({Key? key, required this.userModel}) : super(key: key);

  @override
  State<SearchTile> createState() => _SearchTileState();
}

class _SearchTileState extends State<SearchTile> {
  bool _following = false;
  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          widget.userModel.profileImage,
        ),
      ),
      title: Text(widget.userModel.userId),
      // isThreeLine: true,
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
                    color: isDark ? Colors.black : Colors.white,
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
