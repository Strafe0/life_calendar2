import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/widgets/search/search_sheet.dart';
import 'package:life_calendar2/ui/core/widgets/bottom_sheet.dart';

Future<void> showSearchSheet(BuildContext context) async {
  await showDraggableBottomSheet(
    context,
    title: context.l10n.search,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: SearchSheet(
          onSubmit: (searchDate) {
            context.pop();
          },
        ),
      );
    },
  );
}
