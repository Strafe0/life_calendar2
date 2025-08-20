import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/domain/models/week/event/event.dart';

class EventConverter implements JsonConverter<List<Event>, String> {
  const EventConverter();

  @override
  List<Event> fromJson(String json) {
    try {
      final List values = jsonDecode(json);
      return values
          .map((event) => Event.fromJson(event))
          .toList();
    } on FormatException catch (e, s) {
      logger.e('Failed to parse events', error: e, stackTrace: s);
      return [];
    }
  }

  @override
  String toJson(List<Event> events) => jsonEncode(events);
}
