import 'package:flutter/material.dart';

import 'consts.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Gaps.v32,
          Padding(
            padding: const EdgeInsets.only(left: Sizes.size16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MONDAY 16',
                  style: TextStyle(
                    color: Colors.grey.shade300,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "TODAY",
                      style: TextStyle(
                        fontSize: Sizes.size44,
                        color: Colors.grey.shade100,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.size4),
                      child: Icon(
                        Icons.circle,
                        color: Color(0xf0b22580),
                        size: Sizes.size12,
                      ),
                    ),
                    const Text(
                      "17 18 19 20 21 22 23 24 25",
                      style: TextStyle(
                        fontSize: Sizes.size44,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
