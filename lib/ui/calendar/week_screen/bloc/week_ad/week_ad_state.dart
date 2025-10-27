import 'package:life_calendar2/ui/calendar/week_screen/bloc/week_ad/week_ad_source_enum.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

sealed class WeekAdState {
  const WeekAdState({this.userAge});

  final int? userAge;
}

final class WeekAdInitial extends WeekAdState {
  const WeekAdInitial();
}

final class WeekAdLoadInProgress extends WeekAdState {
  const WeekAdLoadInProgress({super.userAge});
}

final class WeekAdLoadSuccess extends WeekAdState {
  const WeekAdLoadSuccess(this.ad, {super.userAge});

  final RewardedAd ad;
}

final class WeekAdLoadFailure extends WeekAdState {
  const WeekAdLoadFailure(this.error, {super.userAge});

  final AdRequestError error;
}

final class WeekAdShowSuccess extends WeekAdState {
  const WeekAdShowSuccess({required this.source, super.userAge});

  final WeekAdSource source;
}

final class WeekAdShowFailure extends WeekAdState {
  const WeekAdShowFailure({required this.source, super.userAge});

  final WeekAdSource source;
}
