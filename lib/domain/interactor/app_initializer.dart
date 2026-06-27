import 'package:life_calendar/data/services/database_service.dart';
import 'package:life_calendar/utils/result.dart';

/// Owns app bootstrap (database initialization) so presentation depends on an
/// interactor instead of reaching into [DatabaseService] directly.
class AppInitializer {
  final DatabaseService _databaseService;

  const AppInitializer(this._databaseService);

  Future<Result> initialize() => _databaseService.init();
}
