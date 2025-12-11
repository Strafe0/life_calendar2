import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar/core/logger/logger.dart';
import 'package:life_calendar/ui/calendar/week_screen/bloc/week_ad/week_ad_event.dart';
import 'package:life_calendar/ui/calendar/week_screen/bloc/week_ad/week_ad_state.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

class WeekAdBloc extends Bloc<WeekAdEvent, WeekAdState> {
  WeekAdBloc() : super(const WeekAdInitial()) {
    on<WeekAdLoadRequested>(_loadAd);
    on<WeekAdShowRequested>(_showAd);
  }

  @override
  void onChange(Change<WeekAdState> change) {
    super.onChange(change);
    logger.d('WeekAdBloc: $change');
  }

  FutureOr<void> _loadAd(
    WeekAdLoadRequested event,
    Emitter<WeekAdState> emit,
  ) async {
    emit(const WeekAdLoadInProgress());

    final completer = Completer();

    final adLoader = await RewardedAdLoader.create(
      onAdLoaded: (rewardedAd) {
        logger.i('Rewarded ad loaded');

        emit(WeekAdLoadSuccess(rewardedAd, userAge: event.userAge));
        completer.complete();
      },
      onAdFailedToLoad: (error) {
        logger.e('Failed to load rewarded ad', error: error);

        emit(WeekAdLoadFailure(error, userAge: event.userAge));
        completer.complete();
      },
    );

    await adLoader.loadAd(
      adRequestConfiguration: AdRequestConfiguration(
        adUnitId: 'R-M-2265467-3',
        age: event.userAge,
      ),
    );

    logger.d('Rewarded Ad loading started');
    await completer.future;
  }

  FutureOr<void> _showAd(
    WeekAdShowRequested event,
    Emitter<WeekAdState> emit,
  ) async {
    final currentState = state;
    if (currentState is WeekAdLoadSuccess) {
      final ad = currentState.ad;

      await ad.setAdEventListener(
        eventListener: RewardedAdEventListener(
          onAdFailedToShow: (error) {
            ad.destroy();

            add(WeekAdLoadRequested(userAge: state.userAge));
          },
          onAdDismissed: () {
            ad.destroy();

            add(WeekAdLoadRequested(userAge: state.userAge));
          },
        ),
      );

      await ad.show();
      final reward = await ad.waitForDismiss();

      emit(
        reward != null
            ? WeekAdShowSuccess(source: event.source, userAge: state.userAge)
            : WeekAdShowFailure(source: event.source, userAge: state.userAge),
      );
    } else {
      logger.w('Ad is not ready. Current state: $state');
      emit(WeekAdShowFailure(source: event.source, userAge: state.userAge));
    }
  }
}
