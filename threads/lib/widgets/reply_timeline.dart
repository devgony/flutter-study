import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/widgets/reply_circle_avartars.dart';

import '../constants/sizes.dart';
import '../utils.dart';

class ReplyTimeline extends StatelessWidget {
  final int replies;
  final List<String> repliers;
  const ReplyTimeline({
    super.key,
    required this.replies,
    required this.repliers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(
                getImage(),
              ),
              radius: 24,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  radius: 8,
                  child: Icon(
                    FontAwesomeIcons.plus,
                    size: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
        replies > 0
            ? Expanded(
                child: VerticalDivider(
                  width: Sizes.size32,
                  thickness: 0.5,
                  color: Colors.grey.shade600,
                  indent: 10,
                ),
              )
            : Container(),
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 24,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                for (int i = 0; i < repliers.length && i < 3; i++)
                  ReplyCircleAvatars(
                    index: i,
                    length: repliers.length,
                    child: CircleAvatar(
                      foregroundImage: NetworkImage(
                        repliers[i],
                      ),
                      radius: repliers.length >= 3 ? (i + 2) * 3 : 12,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
