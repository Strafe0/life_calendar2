import 'package:life_calendar/ui/calendar/week_screen/bloc/week_ad/week_ad_source_enum.dart';

sealed class WeekAdEvent {
  const WeekAdEvent();
}

final class WeekAdLoadRequested extends WeekAdEvent {
  const WeekAdLoadRequested({required this.userAge});

  final int? userAge;
}

final class WeekAdShowRequested extends WeekAdEvent {
  const WeekAdShowRequested({required this.source});

  final WeekAdSource source;
}
