// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Week _$WeekFromJson(Map<String, dynamic> json) => _Week(
  id: (json['id'] as num).toInt(),
  yearId: (json['yearId'] as num).toInt(),
  start: DateTime.parse(json['start'] as String),
  end: DateTime.parse(json['end'] as String),
  tense: $enumDecode(_$WeekTenseEnumMap, json['tense']),
  assessment: $enumDecode(_$WeekAssessmentEnumMap, json['assessment']),
  goals:
      (json['goals'] as List<dynamic>)
          .map((e) => Goal.fromJson(e as Map<String, dynamic>))
          .toList(),
  events:
      (json['events'] as List<dynamic>)
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
  resume: json['resume'] as String,
  photos: (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$WeekToJson(_Week instance) => <String, dynamic>{
  'id': instance.id,
  'yearId': instance.yearId,
  'start': instance.start.toIso8601String(),
  'end': instance.end.toIso8601String(),
  'tense': _$WeekTenseEnumMap[instance.tense]!,
  'assessment': _$WeekAssessmentEnumMap[instance.assessment]!,
  'goals': instance.goals,
  'events': instance.events,
  'resume': instance.resume,
  'photos': instance.photos,
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
