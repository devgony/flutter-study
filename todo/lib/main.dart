import 'package:flutter/material.dart';
import 'package:todo/task.dart';

import 'calendar.dart';
import 'consts.dart';

const Color primaryColor = Color(0XFF1F1F1F);

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoApp',
      home: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leadingWidth: 80,
          leading: const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://avatars.githubusercontent.com/u/51254761?v=4',
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  size: 36,
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: const [
                Calendar(),
                Gaps.v36,
                Task(
                  from: "11:30",
                  to: "12:20",
                  participants: ["ALEX", "HELENA", "NANA"],
                  backgroundColor: 0xF0FEF754,
                  title: "DESIGN\nMETTING",
                ),
                Gaps.v10,
                Task(
                  from: "12:35",
                  to: "14:10",
                  participants: [
                    "ME",
                    "RICHARD",
                    "CIRY",
                    "MORE",
                    "5",
                    "6",
                    "7"
                  ],
                  backgroundColor: 0xF09C6BCE,
                  title: "DAILY\nPROJECT",
                ),
                Gaps.v10,
                Task(
                  from: "15:00",
                  to: "16:30",
                  participants: ["DEN", "NANA", "MARK"],
                  backgroundColor: 0xF0BBEE4B,
                  title: "WEEKLY\nPLANNING",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
