import 'package:flutter/material.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';

// TODO: improve
class PhotoViewerError extends StatelessWidget {
  const PhotoViewerError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(context.l10n.errorHappened)));
  }
}
