import 'package:flutter/material.dart';
import 'package:life_calendar2/ui/core/dialogs/dialog_action.dart';

Future<T?> showAlertDialog<T>(
  BuildContext context, {
  required String title,
  required String content,
  List<DialogAction>? actions,
}) {
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions
            ?.map(
              (action) => TextButton(
                onPressed: () => action.onPressed(context),
                child: Text(
                  action.title,
                  style: TextTheme.of(context).labelLarge?.copyWith(
                    color: action.color ?? ColorScheme.of(context).primary,
                  ),
                ),
              ),
            )
            .toList(growable: false),
      );
    },
  );
}
