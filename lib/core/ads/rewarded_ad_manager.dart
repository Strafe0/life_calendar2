import 'dart:async';

import 'package:life_calendar2/core/logger.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

class RewardedAdManager {
  Completer<RewardedAd>? _adCompleter;

  Future<void> loadAd({int? age}) async {
    _adCompleter = Completer();

    final adLoader = await RewardedAdLoader.create(
      onAdLoaded: (rewardedAd) {
        _adCompleter?.complete(rewardedAd);
        logger.i('Rewarded ad loaded');
      },
      onAdFailedToLoad: (error) {
        logger.e('Failed to load rewarded ad', error: error);
      },
    );

    // TODO: add real id
    await adLoader.loadAd(
      adRequestConfiguration: AdRequestConfiguration(
        adUnitId: 'demo-rewarded-yandex',
        age: age,
      ),
    );

    await _adCompleter?.future;
  }

  Future<bool> showAd() async {
    final ad = await _adCompleter?.future;
    _adCompleter = null;

    if (ad == null) {
      logger.w('Ad is not ready');
    }

    await ad?.setAdEventListener(
      eventListener: RewardedAdEventListener(
        onAdFailedToShow: (error) {
          ad.destroy();

          loadAd();
        },
        onAdDismissed: () {
          ad.destroy();

          loadAd();
        },
      ),
    );

    await ad?.show();
    final reward = await ad?.waitForDismiss();

    return reward != null;
  }
}
