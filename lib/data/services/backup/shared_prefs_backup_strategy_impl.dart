import 'dart:convert';
import 'dart:io';

import 'package:life_calendar/core/logger/logger.dart';
import 'package:life_calendar/data/services/backup/backup_strategy.dart';
import 'package:life_calendar/data/services/backup/prefs/json_prefs_restore_strategy_impl.dart';
import 'package:life_calendar/data/services/backup/prefs/prefs_restore_strategy.dart';
import 'package:life_calendar/data/services/backup/prefs/xml_prefs_backup_strategy_impl.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesBackupStrategy implements BackupStrategy {
  // Inject the list of restore strategies for maximum flexibility
  const SharedPreferencesBackupStrategy({
    this.restoreStrategies = const [
      JsonPrefsRestoreStrategy(),
      XmlPrefsRestoreStrategy(),
    ],
  });

  final List<PrefsRestoreStrategy> restoreStrategies;

  @override
  String get id => 'shared_prefs';

  @override
  Future<void> backup(Directory destinationDir) async {
    // The backup (export) logic is always the same — to JSON
    try {
      final prefs = await SharedPreferences.getInstance();
      final allPrefs = <String, dynamic>{};
      final keys = prefs.getKeys();

      for (final key in keys) {
        allPrefs[key] = prefs.get(key);
      }

      final jsonFile = File(p.join(destinationDir.path, 'shared_prefs.json'));
      await jsonFile.writeAsString(jsonEncode(allPrefs));
    } catch (e) {
      logger.e('Error exporting SharedPrefs', error: e);
    }
  }

  @override
  Future<void> restore(Directory sourceDir) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Simplified "Chain of Responsibility" pattern
    // Find the first strategy that can handle the data
    for (final strategy in restoreStrategies) {
      if (strategy.canRestore(sourceDir)) {
        logger.d('Restoring prefs using ${strategy.runtimeType}');
        await strategy.restore(sourceDir, prefs);
        return;
      }
    }

    logger.w('No suitable strategy found to restore shared preferences');
  }
}
