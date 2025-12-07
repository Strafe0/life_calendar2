// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Event _$EventFromJson(Map<String, dynamic> json) => _Event(
  id: json['id'] as String,
  title: json['title'] as String,
  date: const DateConverter().fromJson((json['date'] as num).toInt()),
);

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'date': const DateConverter().toJson(instance.date),
};
