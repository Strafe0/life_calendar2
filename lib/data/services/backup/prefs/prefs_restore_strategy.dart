import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

/// Интерфейс для стратегии восстановления настроек из конкретного формата
abstract interface class PrefsRestoreStrategy {
  /// Проверяет, может ли эта стратегия обработать данные в [sourceDir]
  bool canRestore(Directory sourceDir);

  /// Выполняет восстановление
  Future<void> restore(Directory sourceDir, SharedPreferences prefs);
}
