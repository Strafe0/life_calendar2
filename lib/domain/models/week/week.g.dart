// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Week _$WeekFromJson(Map<String, dynamic> json) => _Week(
  id: (json['id'] as num).toInt(),
  yearId: (json['yearId'] as num).toInt(),
  start: const DateConverter().fromJson((json['start'] as num).toInt()),
  end: const DateConverter().fromJson((json['end'] as num).toInt()),
  tense: $enumDecode(_$WeekTenseEnumMap, json['state']),
  assessment: $enumDecode(_$WeekAssessmentEnumMap, json['assessment']),
  goals: const GoalConverter().fromJson(json['goals'] as String),
  events: const EventConverter().fromJson(json['events'] as String),
  resume: json['resume'] as String,
  photos: const PhotoConverter().fromJson(json['photos'] as String),
);

Map<String, dynamic> _$WeekToJson(_Week instance) => <String, dynamic>{
  'id': instance.id,
  'yearId': instance.yearId,
  'start': const DateConverter().toJson(instance.start),
  'end': const DateConverter().toJson(instance.end),
  'state': _$WeekTenseEnumMap[instance.tense]!,
  'assessment': _$WeekAssessmentEnumMap[instance.assessment]!,
  'goals': const GoalConverter().toJson(instance.goals),
  'events': const EventConverter().toJson(instance.events),
  'resume': instance.resume,
  'photos': const PhotoConverter().toJson(instance.photos),
};

const _$WeekTenseEnumMap = {
  WeekTense.past: 'past',
  WeekTense.current: 'current',
  WeekTense.future: 'future',
};

const _$WeekAssessmentEnumMap = {
  WeekAssessment.good: 'Хорошо',
  WeekAssessment.bad: 'Плохо',
  WeekAssessment.poor: 'Нейтрально',
};
