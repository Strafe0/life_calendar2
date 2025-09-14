import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_calendar2/ui/user/bloc/user_bloc.dart';
import 'package:life_calendar2/ui/user/bloc/user_state.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

class AdBlock extends StatefulWidget {
  const AdBlock({super.key, this.onAdSizeCalculated});

  final void Function(int adHeight)? onAdSizeCalculated;

  @override
  State<AdBlock> createState() => _AdBlockState();
}

class _AdBlockState extends State<AdBlock> {
  BannerAd? _bannerAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final userState = context.read<UserBloc>().state;
    final adSize = BannerAdSize.sticky(
      width: MediaQuery.sizeOf(context).width.toInt(),
    );

    adSize.getCalculatedHeight().then(
      (height) => widget.onAdSizeCalculated?.call(height),
    );

    _bannerAd = BannerAd(
      // adUnitId: 'demo-banner-yandex',
      adUnitId: 'R-M-2265467-1',
      adSize: adSize,
      adRequest: AdRequest(
        age: userState is UserSuccess ? userState.user.age : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd != null) {
      return AdWidget(bannerAd: _bannerAd!);
    } else {
      return const SizedBox.shrink();
    }
  }
}
