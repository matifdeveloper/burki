/*
 ********************************************************************************

    _____/\\\\\\\\\_____/\\\\\\\\\\\\\\\__/\\\\\\\\\\\__/\\\\\\\\\\\\\\\_
    ___/\\\\\\\\\\\\\__\///////\\\/////__\/////\\\///__\/\\\///////////__
    __/\\\/////////\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\___________\/\\\_____\/\\\\\\\\\\\_____
    _\/\\\\\\\\\\\\\\\_______\/\\\___________\/\\\_____\/\\\///////______
    _\/\\\/////////\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\________/\\\\\\\\\\\_\/\\\_____________
    _\///________\///________\///________\///////////__\///______________

    Created by Muhammad Atif on 04/01/2024 : 10:03 pm.
    Portfolio https://atifnoori.web.app.
    +923085690603

 ********************************************************************************
 */

import 'package:flutter/material.dart';
import 'package:burki/sources.dart';
import 'package:provider/provider.dart';

class AppRewardedAd {
  // Create instance
  static final AppRewardedAd instance = AppRewardedAd._privateConstructor();

  AppRewardedAd._privateConstructor();

  // Counter for the number of load attempts for rewarded ads.
  int _numRewardedLoadAttempts = 0;
  final int _maxFailedLoadAttempts = 5;

  /// <------------------------ Load Rewarded Ad ------------------------>
  // Function to create a rewarded ad.
  Future<void> createRewardedAd(BuildContext context) async {
    final adsProvider = Provider.of<AdsState>(context, listen: false);

    await RewardedAd.load(
      adUnitId: AdmobHelper.instance.rewardedAdID,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          // Ad loaded successfully.
          FlutterLogger.success('$ad loaded.');
          adsProvider.rewardedAd = ad;
          _numRewardedLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          // Ad failed to load.
          FlutterLogger.error('RewardedAd failed to load: $error');
          adsProvider.rewardedAd = null;
          _numRewardedLoadAttempts += 1;
          FlutterLogger.warning(
              'Num Rewarded Load Attempts $_numRewardedLoadAttempts');
          if (_numRewardedLoadAttempts < _maxFailedLoadAttempts) {
            createRewardedAd(context);
          } else {
            _numRewardedLoadAttempts = 0;
          }
        },
      ),
    );
  }

  /// <------------------------ Show Rewarded Ad ------------------------>
  // Function to show a rewarded ad.
  Future<void> showRewardedAd(
    BuildContext context, {
    void Function(RewardedAd)? onAdShowedFullScreenContent,
    void Function(RewardedAd)? onAdDismissedFullScreenContent,
  }) async {
    final adsProvider = Provider.of<AdsState>(context, listen: false);
    if (adsProvider.rewardedAd == null) {
      // AppToast.show('Warning: attempt to show rewarded before loaded.');
      // AppToast.show('Ad loading please wait...');
      createRewardedAd(Get.currentContext);
      return;
    }
    adsProvider.rewardedAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: onAdShowedFullScreenContent,
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        adsProvider.rewardedAd == null;
        ad.dispose();
        createRewardedAd(Get.currentContext);
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
      },
    );

    await adsProvider.rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      // User earned a reward.
      FlutterLogger.success(
          'Earn with reward $RewardItem(${reward.amount}, ${reward.type})');
      // AppToast.show('Congratulations 🎉!');
    });
  }
}
