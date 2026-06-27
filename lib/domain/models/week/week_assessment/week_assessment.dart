import 'package:freezed_annotation/freezed_annotation.dart';

/// Persisted to the DB by the enum constant name (`good`/`bad`/`poor`).
///
/// Legacy builds (db version < 3) stored localized Russian strings
/// (`Хорошо`/`Плохо`/`Нейтрально`); those are rewritten to these codes by the
/// v2→v3 migration in `DatabaseService`. [poor] is the fallback for any value
/// that fails to deserialize.
@JsonEnum()
enum WeekAssessment { good, bad, poor }
