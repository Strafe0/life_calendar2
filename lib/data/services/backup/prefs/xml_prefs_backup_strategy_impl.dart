import 'dart:io';

import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/data/services/backup/prefs/prefs_restore_strategy.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

/// Unified strategy for restoring preferences from legacy XML file.
/// Works on both Android and iOS by parsing the file manually.
class XmlPrefsRestoreStrategy implements PrefsRestoreStrategy {
  const XmlPrefsRestoreStrategy();

  @override
  bool canRestore(Directory sourceDir) =>
      File(p.join(sourceDir.path, 'FlutterSharedPreferences.xml')).existsSync();

  @override
  Future<void> restore(Directory sourceDir, SharedPreferences prefs) async {
    try {
      final xmlFile = File(
        p.join(sourceDir.path, 'FlutterSharedPreferences.xml'),
      );
      final content = await xmlFile.readAsString();

      // Clean key helper: removes 'flutter.' prefix usually added by the plugin
      String cleanKey(String rawKey) {
        return rawKey.startsWith('flutter.')
            ? rawKey.replaceFirst('flutter.', '')
            : rawKey;
      }

      // 1. Strings
      // Example: <string name="flutter.userName">Alex</string>
      final stringRegex = RegExp('<string name="([^"]+)">([^<]*)</string>');
      for (final match in stringRegex.allMatches(content)) {
        final key = match.group(1);
        final value = match.group(2);
        if (key != null && value != null) {
          final unescaped = value
              .replaceAll('&quot;', '"')
              .replaceAll('&apos;', "'")
              .replaceAll('&lt;', '<')
              .replaceAll('&gt;', '>')
              .replaceAll('&amp;', '&');
          await prefs.setString(cleanKey(key), unescaped);
        }
      }

      // 2. Booleans
      // Example: <boolean name="flutter.isPremium" value="true" />
      final boolRegex = RegExp('<boolean name="([^"]+)" value="([^"]+)" />');
      for (final match in boolRegex.allMatches(content)) {
        final key = match.group(1);
        final value = match.group(2);
        if (key != null && value != null) {
          await prefs.setBool(cleanKey(key), value == 'true');
        }
      }

      // 3. Integers
      // Example: <int name="flutter.launchCount" value="5" />
      final intRegex = RegExp('<int name="([^"]+)" value="([^"]+)" />');
      for (final match in intRegex.allMatches(content)) {
        final key = match.group(1);
        final value = match.group(2);
        if (key != null && value != null) {
          await prefs.setInt(cleanKey(key), int.tryParse(value) ?? 0);
        }
      }

      // 4. Longs (treated as Int in Dart)
      final longRegex = RegExp('<long name="([^"]+)" value="([^"]+)" />');
      for (final match in longRegex.allMatches(content)) {
        final key = match.group(1);
        final value = match.group(2);
        if (key != null && value != null) {
          await prefs.setInt(cleanKey(key), int.tryParse(value) ?? 0);
        }
      }

      // 5. Floats (treated as Double in Dart)
      final floatRegex = RegExp('<float name="([^"]+)" value="([^"]+)" />');
      for (final match in floatRegex.allMatches(content)) {
        final key = match.group(1);
        final value = match.group(2);
        if (key != null && value != null) {
          await prefs.setDouble(cleanKey(key), double.tryParse(value) ?? 0.0);
        }
      }
    } catch (e) {
      logger.e('Error parsing legacy XML prefs', error: e);
    }
  }
}
