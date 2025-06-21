import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:life_calendar2/core/extensions/date_time/date_time_extension.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/calendar_grid/bloc/calendar_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_assessment/week_assessment_widget.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_events/week_event_list_widget.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_fab/week_fab.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_goals/week_goal_list_widget.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_photos/week_photo_list_widget.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_resume/week_resume_widget.dart';

class WeekView extends StatefulWidget {
  const WeekView({super.key, required this.week});

  final Week week;

  @override
  State<WeekView> createState() => _WeekViewState();
}

class _WeekViewState extends State<WeekView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<WeekCubit, WeekState>(
      listener: (context, state) {
        if (state is WeekSuccess) {
          logger.d('Update Calendar with new week');
          context.read<CalendarCubit>().updateWeek(
            week: state.week,
            brightness: MediaQuery.platformBrightnessOf(context),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              '${context.l10n.week} ${widget.week.start.toLocalString(context)} '
              '- ${widget.week.end.toLocalString(context)}',
            ),
            titleSpacing: 0,
            leadingWidth: 48,
          ),
          floatingActionButtonLocation: ExpandableFab.location,
          floatingActionButton: const WeekFab(),
          body: const Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(top: 20),
                  sliver: SliverToBoxAdapter(child: WeekAssessmentWidget()),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: 20),
                  sliver: WeekGoalListWidget(),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: 20),
                  sliver: WeekEventListWidget(),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: 20),
                  sliver: WeekPhotoListWidget(),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: 20),
                  sliver: WeekResumeWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
