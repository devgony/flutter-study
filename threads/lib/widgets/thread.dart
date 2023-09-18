import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/widgets/reply_timeline.dart';
import 'package:threads/models/thread_model.dart';
import 'package:threads/widgets/source.dart';

import '../constants/gaps.dart';
import '../utils.dart';
import 'image_carousel.dart';
import 'more_bottom_sheet.dart';

class Thread extends StatelessWidget {
  final ThreadModel thread;
  const Thread({
    Key? key,
    required this.thread,
  }) : super(key: key);

  void _onTapMore(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const MoreBottomSheet(),
      constraints: BoxConstraints(
        maxHeight: getScreenHeight(context) * 0.4,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final random = RandomGenerator(seed: DateTime.now().millisecondsSinceEpoch);
    final userName = thread.authorId;
    final sentence = thread.body;
    final since = random.integer(60);
    final replies = random.integer(4); // 0~3
    final likes = random.integer(1000);
    final repliers = List.generate(replies, (index) => getImage());

    final sources =
        thread.imageUrls?.map(toImageURL).map(UrlSource.new).toList();

    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: ReplyTimeline(
              replies: replies,
              repliers: repliers,
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      Row(
                        children: [
                          Text("${since}m"),
                          Gaps.h12,
                          GestureDetector(
                            onTap: () => _onTapMore(context),
                            child: const Icon(
                              FontAwesomeIcons.ellipsis,
                              size: 16,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  sentence,
                  style: const TextStyle(fontSize: 16),
                ),
                Gaps.v8,
                if (sources != null) ImageCarousel(sources: sources),
                Gaps.v12,
                SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(FontAwesomeIcons.heart),
                      Icon(FontAwesomeIcons.comment),
                      Icon(FontAwesomeIcons.arrowsRotate),
                      Icon(FontAwesomeIcons.paperPlane),
                    ],
                  ),
                ),
                Gaps.v12,
                Text("$replies replies﹒$likes likes"),
              ],
            ),
          ),
          Gaps.h8,
        ],
      ),
    );
  }
}
