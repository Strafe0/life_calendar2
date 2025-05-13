import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_calendar2/calendar_app.dart';
import 'package:life_calendar2/core/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    logger.f('Fatal error', error: details);
  };
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    return true;
  };

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const CalendarApp());
}
