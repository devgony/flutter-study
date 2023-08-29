import 'package:flutter/widgets.dart';

import '../constants/sizes.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imageUrls;

  const ImageCarousel({Key? key, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        separatorBuilder: (context, index) => const SizedBox(
          width: Sizes.size8,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.size16),
            child: Image.network(
              imageUrls[index],
              // fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
