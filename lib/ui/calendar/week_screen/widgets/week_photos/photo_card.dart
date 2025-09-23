import 'dart:io';

import 'package:flutter/material.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({
    super.key,
    required this.photoUrl,
    this.onPressed,
    this.onLongPressStart,
  });

  final String photoUrl;
  final void Function()? onPressed;
  final void Function(LongPressStartDetails details)? onLongPressStart;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      elevation: 2,
      child: GestureDetector(
        onTap: onPressed,
        onLongPressStart: onLongPressStart,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: Image.file(File(photoUrl), fit: BoxFit.fill),
        ),
      ),
    );
  }
}
