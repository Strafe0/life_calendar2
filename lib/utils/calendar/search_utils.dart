import 'package:life_calendar2/core/logger.dart';

int findWeekIdByDate(
  DateTime date, {
  required DateTime birthdate,
  required int lifeSpan,
}) {
  if (date.isBefore(birthdate)) {
    logger.w('Searched date cannot be earlier than birthdate');
    return -1;
  } else if (date.isAfter(
    DateTime(birthdate.year + lifeSpan + 1, birthdate.month, birthdate.day),
  )) {
    logger.w('Searched date cannot be later than last day');
    return -1;
  }

  final diff = date.difference(birthdate) + const Duration(days: 1);
  logger.d(
    'Found week id: ${diff.inDays / 7} (${diff.inDays ~/ 7 + 1}).\n'
    'Diff: ${diff.inDays}',
  );

  return diff.inDays ~/ 7 + 1;
}
