import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/domain/models/week/week_assessment/week_assessment.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_state.dart';
import 'package:life_calendar2/ui/calendar/week_screen/widgets/week_assessment/assessment_radio_button.dart';
import 'package:life_calendar2/ui/core/themes/week_color.dart';

class WeekAssessmentWidget extends StatelessWidget {
  const WeekAssessmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WeekCubit, WeekState, WeekAssessment>(
      selector: (state) {
        if (state is WeekSuccess) {
          return state.week.assessment;
        }

        logger.w('Return poor assessment, because week is not ready');
        return WeekAssessment.poor;
      },
      builder: (context, selectedAssessment) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 4),
              child: Text(
                'Дайте оценку неделе',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AssessmentRadioButton(
                      assessment: WeekAssessment.good,
                      selectedAssessment: selectedAssessment,
                      color: WeekColor.goodWeekColor,
                    ),
                    AssessmentRadioButton(
                      assessment: WeekAssessment.bad,
                      selectedAssessment: selectedAssessment,
                      color: WeekColor.badWeekColor,
                    ),
                    AssessmentRadioButton(
                      assessment: WeekAssessment.poor,
                      selectedAssessment: selectedAssessment,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
