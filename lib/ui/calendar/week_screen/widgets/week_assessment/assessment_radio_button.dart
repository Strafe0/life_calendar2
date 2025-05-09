import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/domain/models/week/week_assessment/week_assessment.dart';
import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_cubit.dart';

class AssessmentRadioButton extends StatelessWidget {
  const AssessmentRadioButton({
    super.key,
    required this.assessment,
    required this.selectedAssessment,
    required this.color,
  });

  final WeekAssessment assessment;
  final WeekAssessment selectedAssessment;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Radio(
          value: assessment,
          groupValue: selectedAssessment,
          fillColor: WidgetStatePropertyAll(color),
          onChanged: (newAssessment) {
            if (newAssessment != null) {
              context.read<WeekCubit>().changeAssessment(newAssessment);
            }
          },
        ),
        Text(assessment.name, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
