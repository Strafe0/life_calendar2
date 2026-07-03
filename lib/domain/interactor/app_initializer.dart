import 'package:life_calendar/domain/services/database_initializer.dart';
import 'package:life_calendar/utils/result.dart';

/// Owns app bootstrap (database initialization) so presentation depends on an
/// interactor instead of reaching into the database service directly.
class AppInitializer {
  final DatabaseInitializer _databaseInitializer;

  const AppInitializer(this._databaseInitializer);

  Future<Result> initialize() => _databaseInitializer.init();
}
