import 'package:flutter/widgets.dart';
import 'package:threads/widgets/source.dart';

import '../constants/sizes.dart';

class ImageCarousel extends StatelessWidget {
  final List<Source> sources;

  const ImageCarousel({Key? key, required this.sources}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: sources.length,
        separatorBuilder: (context, index) => const SizedBox(
          width: Sizes.size8,
        ),
        itemBuilder: (BuildContext context, int index) => ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.size16),
          child: sources[index],
        ),
      ),
    );
  }
}
