import 'package:flutter/material.dart';
import 'package:life_calendar2/domain/models/week/week.dart';
import 'package:life_calendar2/l10n/app_localizations_extension.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_assessment/week_assessment_widget.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_events/week_event_list_widget.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${context.l10n.week} ${widget.week.start} - ${widget.week.end}',
        ),
        titleSpacing: 0,
        leadingWidth: 48,
      ),
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
    );
  }
}
