import 'package:flutter/material.dart';

class DialogAction {
  const DialogAction({
    required this.onPressed,
    required this.title,
    this.color,
  });

  final void Function(BuildContext context) onPressed;
  final String title;
  final Color? color;
}
