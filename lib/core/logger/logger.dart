import 'package:life_calendar/core/logger/crashlytics_output.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  output: MultiOutput([ConsoleOutput(), CrashlyticsOutput()]),
);
