import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:life_calendar2/calendar_app.dart';
import 'package:life_calendar2/core/logger.dart';

void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    logger.f('Fatal error', error: details);
  };
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    return true;
  };

  runApp(const CalendarApp());
}
