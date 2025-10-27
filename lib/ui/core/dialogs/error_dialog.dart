import 'package:flutter/material.dart';
import 'package:life_calendar2/ui/core/dialogs/dialog_action.dart';

void showErrorDialog(
  BuildContext context, {
  required String title,
  required String content,
  List<DialogAction>? actions,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions
            ?.map(
              (action) => TextButton(
                onPressed: () => action.onPressed(context),
                child: Text(action.title),
              ),
            )
            .toList(growable: false),
      );
    },
  );
}
