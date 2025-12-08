import 'dart:convert';
import 'dart:io';

import 'package:life_calendar2/core/logger.dart';
import 'package:life_calendar2/data/services/backup/backup_strategy.dart';
import 'package:life_calendar2/data/services/backup/prefs/json_prefs_restore_strategy_impl.dart';
import 'package:life_calendar2/data/services/backup/prefs/prefs_restore_strategy.dart';
import 'package:life_calendar2/data/services/backup/prefs/xml_prefs_backup_strategy_impl.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesBackupStrategy implements BackupStrategy {
  // Внедряем список стратегий восстановления для максимальной гибкости
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
    // Логика бэкапа (экспорта) у нас всегда одна - в JSON
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

    // Паттерн "Chain of Responsibility" (упрощенный)
    // Ищем первую подходящую стратегию
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
