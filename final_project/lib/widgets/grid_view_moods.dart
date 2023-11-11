import 'package:flutter/material.dart';

import '../constants/sizes.dart';
import '../models/mood_model.dart';
import '../views/mood_detail_screen.dart';

class GridViewMoods extends StatelessWidget {
  final List<MoodModel> data;
  final double width;
  const GridViewMoods({
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
                mood: data[index],
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
                        "assets/${data[index].moodType.id}.jpg",
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
                        textAlign: TextAlign.center,
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
                    Text(data[index].moodType.emoji),
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
