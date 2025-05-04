import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'name')
enum WeekAssessment {
  good('Хорошо'),
  bad('Плохо'),
  poor('Нейтрально');

  final String name;

  const WeekAssessment(this.name);
}
