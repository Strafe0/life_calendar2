import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';

class CrashlyticsOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    final message = event.lines.join('\n');

    if (event.level == Level.error || event.level == Level.fatal) {
      FirebaseCrashlytics.instance.recordError(
        event.origin.error ?? message,
        event.origin.stackTrace,
        reason: message,
        fatal: event.level == Level.fatal,
      );
    } else {
      FirebaseCrashlytics.instance.log('[${event.level.name}] $message');
    }
  }
}
