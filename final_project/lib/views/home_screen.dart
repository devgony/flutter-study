import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/repositories/authentication_repository.dart';
import 'package:final_project/view_models/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  static const routeName = 'home';
  static const routeURL = '/';
  const HomeScreen({Key? key}) : super(key: key);

  String toElapsedString(Timestamp timestamp) {
    final now = DateTime.now();
    final createdAt = timestamp.toDate();
    final difference = now.difference(createdAt);

    String elapsed;
    if (difference.inMinutes < 60) {
      elapsed = '${difference.inMinutes} minutes';
    } else if (difference.inHours < 24) {
      elapsed = '${difference.inHours} hours';
    } else if (difference.inDays < 7) {
      elapsed = '${difference.inDays} days';
    } else {
      elapsed = DateFormat('yyyy-MM-dd').format(createdAt);
    }

    return '$elapsed ago';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authRepository).signOut();
              context.go("/");
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ref.watch(postProvider).when(
            data: (data) {
              return ListWheelScrollView(
                // diameterRatio: 2,
                itemExtent: 200,
                children: data
                    .map(
                      (post) => FractionallySizedBox(
                        widthFactor: 1,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/${post.emotion.id}.jpg'),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Mood: ${post.emotion.emoji}"),
                              Text(post.payload),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
                // itemBuilder: (context, index) => Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     GestureDetector(
                //       onLongPress: () {
                //         showDialog(
                //           context: context,
                //           builder: (context) => AlertDialog(
                //             title: const Text('Delete post?'),
                //             content: const Text(
                //               'Are you sure you want to delete this post?',
                //             ),
                //             actions: [
                //               TextButton(
                //                 onPressed: () => Navigator.pop(context),
                //                 child: const Text('Cancel'),
                //               ),
                //               TextButton(
                //                 onPressed: () {
                //                   ref
                //                       .read(postProvider.notifier)
                //                       .deletePost(data[index].id);
                //                   Navigator.pop(context);
                //                 },
                //                 child: const Text('Delete'),
                //               ),
                //             ],
                //           ),
                //         );
                //       },
                //       child: Container(
                //         width: double.infinity,
                //         padding: const EdgeInsets.symmetric(horizontal: 20),
                //         decoration: BoxDecoration(
                //           border: Border.all(),
                //         ),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text("Mood: ${data[index].emotion.emoji}"),
                //             Text(data[index].payload),
                //           ],
                //         ),
                //       ),
                //     ),
                //     Text(toElapsedString(data[index].createdAt))
                //   ],
                // ),
                // children: data
                //     .map(
                //       (post) => Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Container(
                //             width: double.infinity,
                //             padding: const EdgeInsets.symmetric(horizontal: 20),
                //             decoration: BoxDecoration(
                //               border: Border.all(),
                //             ),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text("Mood: ${post.emotion.emoji}"),
                //                 Text(post.payload),
                //               ],
                //             ),
                //           ),
                //           Text(toElapsedString(post.createdAt))
                //         ],
                //       ),
                //     )
                //     .toList(),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (error, stackTrace) {
              return Text(error.toString());
            },
          ),
        ),
      ),
    );
  }
}
