import 'package:flutter/widgets.dart';

import 'consts.dart';

class Time extends StatelessWidget {
  final String time;

  const Time({super.key, required this.time});

  String hour(String time) {
    return time.split(":")[0];
  }

  String minute(String time) {
    return time.split(":")[1];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          hour(time),
          style: const TextStyle(
            fontSize: Sizes.size24,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(minute(time)),
      ],
    );
  }
}
