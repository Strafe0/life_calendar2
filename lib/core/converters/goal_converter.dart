import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/domain/models/week/goal/goal.dart';

class GoalConverter implements JsonConverter<List<Goal>, String> {
  const GoalConverter();

  @override
  List<Goal> fromJson(String json) {
    try {
      final List values = jsonDecode(json);
      return values.map((g) => Goal.fromJson(g)).toList(growable: false);
    } on FormatException catch (e, s) {
      logger.e('Failed to parse goals', error: e, stackTrace: s);
      return [];
    }
  }

  @override
  String toJson(List<Goal> goals) => jsonEncode(goals);
}