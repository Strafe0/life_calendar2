import 'package:flutter/material.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';

class CalendarViewLoadingBody extends StatelessWidget {
  const CalendarViewLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(context.l10n.loading));
  }
}
