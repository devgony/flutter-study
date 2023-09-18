import 'dart:io';

import 'package:flutter/widgets.dart';

import '../constants/sizes.dart';

enum SourceType {
  url,
  file,
}

class Source {
  final SourceType type;
  final dynamic value; // TODO: should be with enum variant

  const Source.url(this.value) : type = SourceType.url;
  const Source.file(this.value) : type = SourceType.file;
}

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
        itemBuilder: (BuildContext context, int index) {
          final source = sources[index];
          if (source.type == SourceType.url) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.size16),
              child: Image.network(
                source.value,
                fit: BoxFit.cover,
              ),
            );
          } else {
            return ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.size16),
              child: Image.file(
                File(source.value.path),
                fit: BoxFit.cover,
              ),
            );
          }
        },
      ),
    );
  }
}
