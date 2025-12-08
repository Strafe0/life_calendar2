import 'dart:convert' show jsonDecode;
import 'dart:io';

import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/data/services/backup/prefs/prefs_restore_strategy.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

class JsonPrefsRestoreStrategy implements PrefsRestoreStrategy {
  const JsonPrefsRestoreStrategy();

  @override
  bool canRestore(Directory sourceDir) =>
      File(p.join(sourceDir.path, 'shared_prefs.json')).existsSync();

  @override
  Future<void> restore(Directory sourceDir, SharedPreferences prefs) async {
    try {
      final file = File(p.join(sourceDir.path, 'shared_prefs.json'));
      final jsonString = await file.readAsString();
      final map = jsonDecode(jsonString) as Map<String, dynamic>;

      for (final key in map.keys) {
        final val = map[key];
        if (val is bool) {
          await prefs.setBool(key, val);
        } else if (val is int) {
          await prefs.setInt(key, val);
        } else if (val is double) {
          await prefs.setDouble(key, val);
        } else if (val is String) {
          await prefs.setString(key, val);
        } else if (val is List) {
          await prefs.setStringList(key, List<String>.from(val));
        }
      }
    } catch (e) {
      logger.e('Error restoring from JSON prefs', error: e);
    }
  }
}
