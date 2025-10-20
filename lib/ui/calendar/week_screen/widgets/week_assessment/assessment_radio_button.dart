import 'package:flutter/material.dart';
import 'package:life_calendar2/domain/models/week/week_assessment/week_assessment.dart';

class AssessmentRadioButton extends StatelessWidget {
  const AssessmentRadioButton({
    super.key,
    required this.assessment,
    required this.color,
  });

  final WeekAssessment assessment;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Radio(value: assessment, fillColor: WidgetStatePropertyAll(color)),
        Text(assessment.name, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
