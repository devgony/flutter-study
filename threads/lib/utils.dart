import 'dart:math';

String getImage() {
  final random = Random();
  return 'https://picsum.photos/300/200?hash=${random.nextInt(10000)}';
}
