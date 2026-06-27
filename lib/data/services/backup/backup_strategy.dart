import 'dart:io';

/// Interface for backing up a single component.
abstract interface class BackupStrategy {
  /// Strategy identifier (for logs or the folder structure).
  String get id;

  /// Copies the data into the archive folder [destinationDir].
  Future<void> backup(Directory destinationDir);

  /// Restores the data from the archive folder [sourceDir].
  Future<void> restore(Directory sourceDir);
}
