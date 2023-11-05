import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/gaps.dart';
import '../models/user_model.dart';
import '../view_models/settings_view_model.dart';

class ActivityTile extends ConsumerWidget {
  final UserModel userModel;
  const ActivityTile({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faker = Faker();
    final activity = faker.randomGenerator.element([
      'Mentioned you',
      'Starting out my gardening club with thr...',
      'Followed you',
      'Definitely broken!',
      'Liked your post',
      'Replied to your post'
    ]);
    final hours = faker.randomGenerator.integer(9, min: 1);
    final payload = faker.lorem.sentence();
    final following = faker.randomGenerator.integer(5, min: 1) == 1;

    final isDark = ref.watch(settingsProvider).darkMode;

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          userModel.profileImage,
        ),
      ),
      title: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(
              userModel.uid,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Gaps.h12,
          Text(
            '${hours}h',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          )
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activity,
          ),
          Text(
            payload,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      trailing: following
          ? Container(
              width: 80,
              height: 30,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                border: Border(
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
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Text('Following'),
            )
          : const SizedBox(),
    );
  }
}
