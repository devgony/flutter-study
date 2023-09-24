import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/models/thread_model.dart';
import '../constants/gaps.dart';
import '../constants/sizes.dart';
import '../utils.dart';
import 'image_carousel.dart';
import 'more.dart';

class Thread extends StatelessWidget {
  final ThreadModel thread;
  const Thread({
    Key? key,
    required this.thread,
  }) : super(key: key);

  Widget getCircleAvatar(
    int i,
    Widget child,
    int length,
  ) {
    if (length == 3) {
      switch (i) {
        case 2:
          return Positioned(
            top: 8,
            right: 0,
            child: child,
          );
        case 1:
          return Positioned(
            bottom: 12,
            left: 4,
            child: child,
          );
        default:
          return Positioned(
            bottom: 0,
            right: 14,
            child: child,
          );
      }
    } else if (length == 2) {
      switch (i) {
        case 1:
          return Positioned(
            left: 4,
            bottom: 0,
            child: child,
          );
        default:
          return Positioned(
            right: 4,
            bottom: 0,
            child: child,
          );
      }
    } else {
      return Positioned(
        bottom: 0,
        right: 14,
        child: child,
      );
    }
  }

  void _onTapMore(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const More(),
      constraints: BoxConstraints(
        maxHeight: getScreenHeight(context) * 0.4,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final faker = Faker();
    final random = RandomGenerator(seed: DateTime.now().millisecondsSinceEpoch);
    final userName = thread.authorId;
    final sentence = thread.body;
    final since = random.integer(60);
    final replies = random.integer(4); // 0~3
    final likes = random.integer(1000);
    final hasImage = random.integer(3) != 0;

    final repliers = List.generate(replies, (index) => getImage());
    // final images = List.generate(5, (index) => getImage());

    final sources = thread.imageUrls?.map(toImageURL).map(Source.url).toList();

    // final String? imageUrl = thread.imageUrl != null
    //     ? "https://firebasestorage.googleapis.com/v0/b/threads-henry.appspot.com/o/${thread.imageUrl!.substring(1).replaceAll("/", "%2F")}?alt=media"
    //     : null;
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.end,
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
                // CircleAvatar(
                //   // TODO: three small avatars
                //   foregroundImage: NetworkImage(
                //     getImage(),
                //   ),
                //   radius: 24,
                // ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 24,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        for (int i = 0; i < repliers.length && i < 3; i++)
                          getCircleAvatar(
                            i,
                            CircleAvatar(
                              foregroundImage: NetworkImage(
                                repliers[i],
                              ),
                              radius: repliers.length >= 3 ? (i + 2) * 3 : 12,
                            ),
                            repliers.length,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
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
                          // fontSize: 16,
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
                // if (imageUrl != null) Image.network(imageUrl),
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
