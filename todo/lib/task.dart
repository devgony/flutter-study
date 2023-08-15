import 'package:flutter/material.dart';
import 'package:todo/time.dart';

import 'consts.dart';

class Task extends StatelessWidget {
  final String from;
  final String to;
  final List<String> participants;
  final int backgroundColor;
  final String title;

  const Task({
    super.key,
    required this.from,
    required this.to,
    required this.participants,
    required this.backgroundColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      padding: const EdgeInsets.all(Sizes.size24),
      decoration: BoxDecoration(
        color: Color(backgroundColor),
        borderRadius: BorderRadius.circular(Sizes.size36),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Time(
                time: from,
              ),
              const SizedBox(
                height: Sizes.size24,
                child: VerticalDivider(
                  thickness: 0.5,
                  color: Colors.black,
                ),
              ),
              Time(
                time: to,
              ),
            ],
          ),
          Gaps.h16,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  height: 0.95,
                  fontSize: Sizes.size56,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  for (final participant in participants.take(3)) ...[
                    Text(
                      participant,
                      style: TextStyle(
                        color: participant == "ME"
                            ? Colors.black
                            : Colors.grey.shade500,
                      ),
                    ),
                    Gaps.h24,
                  ],
                  participants.length > 3
                      ? Text(
                          "+${participants.length - 3}",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        )
                      : Container(),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
