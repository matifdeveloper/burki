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

    Created by Muhammad Atif on 05/01/2024 : 11:51 pm.
    Portfolio https://atifnoori.web.app.
    +923085690603

 ********************************************************************************
 */

import 'package:burki/sources.dart';
import 'package:flutter/material.dart';

class AdMobBanner extends StatefulWidget {
  const AdMobBanner({super.key});

  @override
  State<AdMobBanner> createState() => _AdMobBannerState();
}

class _AdMobBannerState extends State<AdMobBanner> {
  BannerAd? _admobBannerAd;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    BannerAd(
      adUnitId: AdmobHelper.instance.bannerAdID,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _admobBannerAd = ad as BannerAd;
            });
          }
        },
        onAdFailedToLoad: (ads, error) {
          FlutterLogger.error("Failed to load ad ${error.message}");
          ads.dispose();
        },
      ),
    ).load();
  }

  @override
  void dispose() {
    _admobBannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _admobBannerAd == null
        ? const SizedBox
            .shrink() // Return an empty SizedBox if banner ad is null
        : SizedBox(
            width: _admobBannerAd!.size.width.toDouble(),
            height: _admobBannerAd!.size.height.toDouble(),
            child: AdWidget(
              ad: _admobBannerAd!,
              key: UniqueKey(),
            ),
          );
  }
}
