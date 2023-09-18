import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraBottom extends StatelessWidget {
  const CameraBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
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
                  final navigator = Navigator.of(context);
                  final pictures = await ImagePicker().pickMultiImage();

                  if (pictures.isEmpty) return;

                  navigator.pop(pictures);
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
