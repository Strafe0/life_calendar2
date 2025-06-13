import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:life_calendar2/core/logger.dart';

class PhotoConverter implements JsonConverter<List<String>, String> {
  const PhotoConverter();

  @override
  List<String> fromJson(String json) {
    try {
      final List photos = jsonDecode(json);
      return photos.map((photo) => photo as String).toList(growable: false);
    } on FormatException catch (e, s) {
      logger.e('Failed to parse photos', error: e, stackTrace: s);
      return [];
    }
  }

  @override
  String toJson(List<String> photos) => jsonEncode(photos);
}
