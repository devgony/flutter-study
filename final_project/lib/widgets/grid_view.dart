import 'package:flutter/material.dart';

import '../constants/sizes.dart';
import '../models/post_model.dart';
import '../views/mood_detail_screen.dart';

class GridViewPosts extends StatelessWidget {
  final List<PostModel> data;
  final double width;
  const GridViewPosts({
    super.key,
    required this.data,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: Sizes.size2,
          mainAxisSpacing: Sizes.size2,
          childAspectRatio: 9 / 14,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MoodDetailScreen(
                postModel: data[index],
              ),
            ),
          ),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 9 / 14,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/${data[index].mood.id}.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.2),
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        data[index].payload,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                width: width,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(data[index].mood.emoji),
                    Text(
                      data[index].yearMonthDay(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
