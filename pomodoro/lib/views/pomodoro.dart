import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/min_button.dart';

import '../widgets/time_tile.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

final mins = List.generate(7, (i) => 5 + i * 5).toList();

class _PomodoroState extends State<Pomodoro> {
  static const _initMin = 15;
  var targetMin = _initMin;
  var sec = _initMin * 60;
  var playing = false;
  var isBreak = false;
  var round = 0;
  var goal = 0;

  void countDown() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 1));
      setState(() {
        sec = sec - 1;
      });

      if (isBreak) {
        if (sec == 0) {
          playing = false;
          sec = targetMin * 60;
          isBreak = false;

          return false;
        }
      } else {
        if (sec == 0) {
          playing = false;
          isBreak = true;
          sec = 5 * 60;
          if (round >= 3) {
            round = 0;
            goal++;
          } else {
            round++;
          }

          return false;
        }
      }

      return playing && sec > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isBreak ? Colors.purple : Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            isBreak ? Colors.purple : Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'Minchodoro',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          isBreak
              ? Text(
                  'Break till bored',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : const Text(
                  'Work till die',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimeTile(
                time: (sec / 60).floor(),
              ),
              const Text(
                ':',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
              TimeTile(time: sec % 60)
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var min in mins)
                  MinButton(
                    min: min,
                    selected: min == targetMin,
                    onPressed: () => setState(() {
                      targetMin = min;
                      sec = min * 60;
                    }),
                  )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => setState(() {
                  playing = !playing;
                  if (playing) {
                    countDown();
                  }
                }),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade700,
                  ),
                  child: Icon(
                    playing ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () => setState(() {
                  playing = false;
                  sec = targetMin * 60;
                }),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade700,
                  ),
                  child: const Icon(
                    Icons.replay,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Round: $round/4'),
              const SizedBox(width: 20),
              Text('Goal: $goal/12'),
            ],
          ),
        ],
      ),
    );
  }
}
