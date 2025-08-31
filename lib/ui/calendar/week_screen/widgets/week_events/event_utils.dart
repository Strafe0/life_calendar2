import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/domain/models/week/event/event.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_events/event_change_sheet.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_fab/week_fab_state_provider.dart';
import 'package:life_calendar2/ui/core/widgets/bottom_sheet.dart';

Future<void> showEventSheet(BuildContext context, {Event? event}) async {
  final weekCubit = context.read<WeekCubit>();
  final fabState = WeekFabStateProvider.of(context);

  final weekState = weekCubit.state as WeekSuccess;
  final startDate = weekState.week.start;
  final endDate = weekState.week.end;

  final isCreation = event == null;

  await showDraggableBottomSheet(
    context,
    title: isCreation ? context.l10n.eventCreation : context.l10n.eventEdit,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: EventChangeSheet(
          firstDate: startDate,
          lastDate: endDate,
          initialDate: event?.date,
          initialTitle: event?.title,
          onSubmit: (date, title) async {
            if (isCreation) {
              await weekCubit.addEvent(date, title);
            } else {
              await weekCubit.changeEvent(
                event.copyWith(title: title, date: date),
              );
            }
            if (context.mounted) {
              context.pop();
            }
          },
        ),
      );
    },
  );

  fabState.close();
}
