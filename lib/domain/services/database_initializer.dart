import 'package:life_calendar/utils/result.dart';

/// Bootstraps the underlying database. Lets app-bootstrap interactors depend on
/// an abstraction instead of reaching into the concrete `DatabaseService`.
abstract interface class DatabaseInitializer {
  Future<Result> init();
}
