import 'package:flutter/material.dart';
import 'package:life_calendar2/core/logger/logger.dart';

void showErrorSnackBar(BuildContext context, {required String text}) {
  final theme = Theme.of(context);
  final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);

  if (scaffoldMessenger == null) {
    logger.w('Cannot show snackbar');
  }

  scaffoldMessenger?.removeCurrentSnackBar();
  scaffoldMessenger?.showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.onError,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: theme.colorScheme.error,
      duration: const Duration(seconds: 3),
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.sizeOf(context).height - 100,
      ),
      dismissDirection: DismissDirection.up,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    snackBarAnimationStyle: AnimationStyle.noAnimation,
  );
}
