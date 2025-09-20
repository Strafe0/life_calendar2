import 'dart:io';

import 'package:flutter/material.dart';

// TODO: add onTap for opening photo to full screen
// TODO: add longTap to delete photo
class PhotoCard extends StatelessWidget {
  const PhotoCard({super.key, required this.photoUrl, this.onPressed});

  final String photoUrl;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        elevation: 2,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: Image.file(File(photoUrl), fit: BoxFit.fill),
        ),
      ),
    );
  }
}
