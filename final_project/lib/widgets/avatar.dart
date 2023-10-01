import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../view_models/avatar_view_model.dart';

const projectName = "final-henry-b849e";

class Avatar extends ConsumerWidget {
  final String email;
  final String uid;
  final double size;
  final hasAvatar;

  const Avatar({
    super.key,
    required this.email,
    required this.uid,
    required this.hasAvatar,
    this.size = 50.0,
  });

  Future<void> _onAvatarTap(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );
    if (xfile != null) {
      final file = File(xfile.path);
      ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;
    return GestureDetector(
      onTap: isLoading ? null : () => _onAvatarTap(ref),
      child: isLoading
          ? Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator(),
            )
          : CircleAvatar(
              radius: size,
              foregroundImage: hasAvatar
                  ? NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/$projectName.appspot.com/o/avatars%2F$uid?alt=media&haha=${DateTime.now().toString()}",
                    )
                  : null,
              child: Text(
                email.substring(0, 1),
                style: const TextStyle(fontSize: 10),
              ),
            ),
    );
  }
}
