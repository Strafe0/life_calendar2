import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_ad/week_ad_bloc.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_ad/week_ad_event.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_ad/week_ad_source_enum.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_ad/week_ad_state.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_events/event_utils.dart';

class EventFab extends StatelessWidget {
  const EventFab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeekAdBloc, WeekAdState>(
      listener: (context, state) {
        if (state is WeekAdShowSuccess && state.source.isEvents) {
          showEventSheet(context);
        }
      },
      child: FloatingActionButton.extended(
        heroTag: null,
        backgroundColor: Theme.of(context).cardTheme.color,
        foregroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          final weekCubit = context.read<WeekCubit>();

          if (weekCubit.isEventsExceededLimit) {
            context.read<WeekAdBloc>().add(
              const WeekAdShowRequested(source: WeekAdSource.events),
            );

            return;
          }

          showEventSheet(context);
        },
        label: Text(context.l10n.event),
        icon: const Icon(Icons.calendar_today),
      ),
    );
  }
}
