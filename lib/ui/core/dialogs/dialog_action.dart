import 'package:flutter/material.dart';

class DialogAction {
  const DialogAction({required this.onPressed, required this.title});

  final void Function(BuildContext context) onPressed;
  final String title;
}