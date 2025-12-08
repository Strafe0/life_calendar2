import 'dart:io';

/// Интерфейс для стратегии резервного копирования отдельного компонента
abstract interface class BackupStrategy {
  /// Идентификатор стратегии (для логов или структуры папок)
  String get id;

  /// Выполняет копирование данных в папку архива [destinationDir]
  Future<void> backup(Directory destinationDir);

  /// Выполняет восстановление данных из папки архива [sourceDir]
  Future<void> restore(Directory sourceDir);
}
