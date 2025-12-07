import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:life_calendar2/core/converters/date_converter.dart';

part 'event.freezed.dart';

part 'event.g.dart';

@freezed
abstract class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    @DateConverter() required DateTime date,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
