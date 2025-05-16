import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_events/event_widget.dart';

class WeekEventListWidget extends StatelessWidget {
  const WeekEventListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(left: 12, bottom: 4),
          sliver: SliverToBoxAdapter(
            child: Text(
              context.l10n.events,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        BlocBuilder<WeekCubit, WeekState>(
          builder: (context, state) {
            final events = state is WeekSuccess ? state.week.events : [];

            if (events.isEmpty) {
              return SliverToBoxAdapter(
                child: Center(child: Text(context.l10n.noEvents)),
              );
            }

            return SliverList.builder(
              itemCount: events.length,
              itemBuilder: (_, index) => EventWidget(event: events[index]),
            );
          },
        ),
      ],
    );
  }
}
