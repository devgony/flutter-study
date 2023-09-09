import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/gaps.dart';
import '../constants/sizes.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();

  static const String routeName = 'camera';
  static const String routeUrl = '/camera';
}

class _CameraScreenState extends State<CameraScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  List<String> _deniedPermissions = [];
  bool _isSelfieMode = false;
  // final double _maximumZoomLevel = 0.0;
  // final double _minimumZoomLevel = 0.0;
  // final double _currentZoomLevel = 0.0;
  // final double _zoomLevelStep = 0.05;

  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  late final Animation<double> _buttonAnimation =
      Tween(begin: 0.5, end: 1.3).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  late FlashMode _flashMode;
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // _stopRecording();
      }
    });
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    if (!_noCamera) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_noCamera) return;
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;

    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
    } else {
      _deniedPermissions = [
        if (cameraDenied) "Camera",
        if (micDenied) "Microphone",
      ];
    }
    setState(() {});
  }

  Future<void> initCamera() async {
    if (!mounted) return;

    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    // handle selfie mode
    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );

    await _cameraController.initialize();

    await _cameraController.prepareForVideoRecording(); // for IOS

    _flashMode = _cameraController.value.flashMode;
    // _maximumZoomLevel = await _cameraController.getMaxZoomLevel();
    // _minimumZoomLevel = await _cameraController.getMinZoomLevel();

    setState(() {});
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _starRecording(TapDownDetails _) async {
    if (_cameraController.value.isTakingPicture) return;

    final picture = await _cameraController.takePicture();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();

    if (!mounted) return;

    Navigator.of(context).pop(picture);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => WriteScreen(
    //       picture: picture,
    //     ),
    //   ),
    // );
  }

  // Future<void> _stopRecording() async {
  //   if (!_cameraController.value.isTakingPicture) return;

  //   _buttonAnimationController.reverse();
  //   _progressAnimationController.reset();

  //   // get picture from camera
  //   // final picture = await _cameraController.

  //   if (!mounted) return;

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => PicturePreviewScreen(
  //         video: video,
  //         isPicked: false,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: BackButton(
      //     color: Colors.white,
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Initializing...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v20,
                  const CircularProgressIndicator.adaptive(),
                  Gaps.v20,
                  const Text(
                    "Please grant the following permissions:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v20,
                  _deniedPermissions.isEmpty
                      ? const SizedBox()
                      : Text(
                          "• ${_deniedPermissions.join(", ")}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size20,
                          ),
                        ),
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  if (!_noCamera && _cameraController.value.isInitialized)
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(Sizes.size36),
                        ),
                        child: CameraPreview(_cameraController),
                      ),
                    ),
                  Positioned(
                    top: Sizes.size40,
                    left: Sizes.size20,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Icon(
                          Icons.flash_off,
                          color: Colors.white,
                        ),
                        ScaleTransition(
                          scale: _buttonAnimation,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 60 + 16,
                                width: 60 + 16,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              Container(
                                height: 60 + 8,
                                width: 60 + 8,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              GestureDetector(
                                onTapDown: _starRecording,
                                // () {
                                //   if (_cameraController.value.isTakingPicture) {
                                //     return;
                                //   }
                                //   _cameraController.takePicture();
                                //   _buttonAnimationController.forward();
                                //   _progressAnimationController.forward();
                                // },
                                // onTapUp: (details) => _stopRecording(),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _toggleSelfieMode(),
                          child: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 18),
        child: Row(
          children: [
            const Expanded(child: SizedBox()),
            const Expanded(
              child: Text(
                'Camera',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  final picture = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );

                  if (picture == null) return;

                  Navigator.of(context).pop(picture);
                },
                child: const Text(
                  'Library',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
