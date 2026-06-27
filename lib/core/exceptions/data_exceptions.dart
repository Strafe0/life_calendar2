/// Thrown when a requested week is not present in the database.
///
/// Implements [Exception] (not [Error]) so repository `on Exception` handlers
/// catch it and surface it as a `Result.error` instead of crashing.
class WeekNotFoundException implements Exception {
  const WeekNotFoundException(this.message);

  final String message;

  @override
  String toString() => 'WeekNotFoundException: $message';
}

/// Thrown when the stored user profile is missing required data (e.g. no
/// birthdate), so it can be surfaced as a `Result.error` with context instead
/// of an empty `Exception`.
class UserDataException implements Exception {
  const UserDataException(this.message);

  final String message;

  @override
  String toString() => 'UserDataException: $message';
}
