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

    Created by Muhammad Atif on 04/01/2024 : 9:48 pm.
    Portfolio https://atifnoori.web.app.
    +923085690603

 ********************************************************************************
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:burki/sources.dart';

class InitAd {
  // Create instance
  static final InitAd instance = InitAd._privateConstructor();

  InitAd._privateConstructor();

  int _numInterstitialLoadAttempts = 0;

  /// Asynchronously creates and loads an [interstitial] ad.
  Future<void> createInterstitialAd(BuildContext context, {bool load = true}) async {
    if (!load) return;

    final adsProvider = Provider.of<AdsState>(context, listen: false);

    // Dispose existing ad if present
    if (adsProvider.interstitialAd != null) {
      adsProvider.interstitialAd!.dispose();
    }

    // Load new interstitial ad
    await InterstitialAd.load(
      adUnitId: AdmobHelper.instance.initAdID,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          FlutterLogger.success('$ad loaded');
          adsProvider.interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          adsProvider.interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          FlutterLogger.error('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          adsProvider.interstitialAd = null;

          // Retry loading if attempts are less than 5
          if (_numInterstitialLoadAttempts < 5) {
            createInterstitialAd(Get.currentContext);
          }
        },
      ),
    );
  }


  /// Displays the loaded [interstitial] ad.
  void showInterstitialAd(BuildContext context) {
    final adsProvider = Provider.of<AdsState>(context, listen: false);

    // Check if the interstitial ad is loaded
    if (adsProvider.interstitialAd == null) {
      createInterstitialAd(Get.currentContext);
      return;
    }

    // Set callbacks and show the interstitial ad
    adsProvider.interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          FlutterLogger.info('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        FlutterLogger.info('$ad onAdDismissedFullScreenContent.');
        adsProvider.interstitialAd = null;
        ad.dispose();
        createInterstitialAd(Get.currentContext);
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        FlutterLogger.error('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
    );

    adsProvider.interstitialAd!.show();
  }
}
