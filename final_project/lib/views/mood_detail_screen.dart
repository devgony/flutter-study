import 'package:final_project/models/post_model.dart';
import 'package:flutter/material.dart';

class MoodDetailScreen extends StatefulWidget {
  final PostModel postModel;

  const MoodDetailScreen({
    super.key,
    required this.postModel,
  });

  @override
  State<MoodDetailScreen> createState() => _MoodDetailScreenState();
}

class _MoodDetailScreenState extends State<MoodDetailScreen>
    with TickerProviderStateMixin {
  // late final AnimationController _progressController = AnimationController(
  //   vsync: this,
  //   duration: const Duration(minutes: 1),
  // );

  // late final AnimationController _marqueeController = AnimationController(
  //   vsync: this,
  //   duration: const Duration(
  //     seconds: 20,
  //   ),
  // );

  late final AnimationController _playPauseController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 500,
    ),
  );

  // late final Animation<Offset> _marqueeTween = Tween(
  //   begin: const Offset(0.1, 0),
  //   end: const Offset(-0.6, 0),
  // ).animate(_marqueeController);

  String toTimeString(double value) {
    final duration = Duration(milliseconds: (value * 60000).toInt());
    final timeString =
        '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    return timeString;
  }

  @override
  void dispose() {
    // _progressController.dispose();
    // _marqueeController.dispose();
    super.dispose();
  }

  // void _onPlayPauseTap() {
  //   if (_playPauseController.isCompleted) {
  //     _playPauseController.reverse();
  //   } else {
  //     _playPauseController.forward();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.postModel.mood.id.toUpperCase()),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.center,
            child: Hero(
              tag: widget.postModel.id,
              child: Container(
                clipBehavior: Clip.hardEdge,
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    )
                  ],
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/${widget.postModel.mood.id}.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.black.withOpacity(0.2),
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      textAlign: TextAlign.center,
                      widget.postModel.payload,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          // AnimatedBuilder(
          //   animation: _progressController,
          //   builder: (context, child) => Column(
          //     children: [
          //       CustomPaint(
          //         size: Size(size.width - 80, 5),
          //         painter: ProgressBar(
          //           progressValue: _progressController.value,
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 10,
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 40),
          //         child: Row(
          //           children: [
          //             Text(
          //               toTimeString(_progressController.value),
          //               style: const TextStyle(
          //                 fontSize: 12,
          //                 color: Colors.grey,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //             ),
          //             const Spacer(),
          //             Text(
          //               toTimeString(1 - _progressController.value),
          //               style: const TextStyle(
          //                 fontSize: 12,
          //                 color: Colors.grey,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //     ],
          // ),
          // ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.postModel.mood.id.toUpperCase(),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          // SlideTransition(
          //   position: _marqueeTween,
          //   child: const Text(
          //     "A Film By Christopher Nolan - Original Motion Picture Soundtrack",
          //     maxLines: 1,
          //     overflow: TextOverflow.visible,
          //     softWrap: false,
          //     style: TextStyle(fontSize: 18),
          //   ),
          // ),
          const SizedBox(
            height: 30,
          ),
          Text(
            widget.postModel.mood.emoji,
            style: const TextStyle(fontSize: 48),
          ),

          // GestureDetector(
          //   onTap: _onPlayPauseTap,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       AnimatedIcon(
          //         icon: AnimatedIcons.play_pause,
          //         progress: _playPauseController,
          //         size: 60,
          //       ),
          //       // LottieBuilder.asset(
          //       //   "assets/animations/play-lottie.json",
          //       //   controller: _playPauseController,
          //       //   width: 200,
          //       //   height: 100,
          //       // )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}

class ProgressBar extends CustomPainter {
  final double progressValue;

  ProgressBar({
    required this.progressValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final progress = size.width * progressValue;

    // track

    final trackPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;

    final trackRRect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      const Radius.circular(10),
    );

    canvas.drawRRect(trackRRect, trackPaint);

    // progress
    final progressPaint = Paint()
      ..color = Colors.grey.shade500
      ..style = PaintingStyle.fill;

    final progressRRect = RRect.fromLTRBR(
      0,
      0,
      progress,
      size.height,
      const Radius.circular(10),
    );

    canvas.drawRRect(progressRRect, progressPaint);

    // thumb

    canvas.drawCircle(
      Offset(progress, size.height / 2),
      7.5,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ProgressBar oldDelegate) {
    return oldDelegate.progressValue != progressValue;
  }
}
