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

    Created by Muhammad Atif on 3/12/2024.
    Portfolio https://atifnoori.web.app.
    IsloAI

 *********************************************************************************/

import 'package:flutter/material.dart';

class ScreenSize {

  static late MediaQueryData _mediaQueryData;
  static late Orientation orientation;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double viewInsectsBottom;

  // static late double defaultSize;

  ScreenSize.init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    orientation = _mediaQueryData.orientation;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    viewInsectsBottom = _mediaQueryData.viewInsets.bottom;
  }
}

extension Sizes on num {
  double get w {
    final double screenWidth = ScreenSize.screenWidth;

    // 375 is the layout width that designer use 1366 for tab
    int width = ScreenSize.screenWidth > 700 ? screenWidth.toInt() : 414;
    return (toDouble() / width) * screenWidth;
  }

  double get h {
    final double screenHeight = ScreenSize.screenHeight;
    // 812 is the layout height that designer use {use your own designer height}
    int height = screenHeight
        .toInt(); //(Size.screenHeight < 700 && Size.screenWidth > 700) ? 320 : 852;

    return (toDouble() / height) * screenHeight;
  }

  SizedBox get height => SizedBox(
        height: toDouble().w,
      );

  SizedBox get width => SizedBox(
        width: toDouble().w,
      );
}
