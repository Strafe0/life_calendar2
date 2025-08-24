import 'package:flutter/material.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';

class WeekFailureView extends StatelessWidget {
  const WeekFailureView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(context.l10n.errorHappened));
  }
}
