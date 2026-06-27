import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

/// Interface for restoring settings from a specific format.
abstract interface class PrefsRestoreStrategy {
  /// Whether this strategy can handle the data in [sourceDir].
  bool canRestore(Directory sourceDir);

  /// Performs the restore.
  Future<void> restore(Directory sourceDir, SharedPreferences prefs);
}
