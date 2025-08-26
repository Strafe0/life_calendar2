import 'dart:io';

import 'package:flutter/material.dart';

// TODO: add onTap for opening photo to full screen
// TODO: add longTap to delete photo
class PhotoWidget extends StatelessWidget {
  const PhotoWidget({super.key, required this.photoUrl});

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      elevation: 2,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Image.file(File(photoUrl), fit: BoxFit.fill),
      ),
    );
  }
}
