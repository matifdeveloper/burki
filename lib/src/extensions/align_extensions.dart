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

    Created by Muhammad Atif on 5/20/2024.
    Portfolio https://atifnoori.web.app.
    IsloAI

 *********************************************************************************/

import 'package:flutter/material.dart';

// Extension on Widget to provide various alignment methods
extension AlignExtensions on Widget {
  // Aligns the widget to the top-left corner
  Widget alignTopLeft() {
    return Align(
      // Set alignment to top-left
      alignment: Alignment.topLeft,
      // The widget to be aligned
      child: this,
    );
  }

  // Aligns the widget to the top-center
  Widget alignTopCenter() {
    return Align(
      // Set alignment to top-center
      alignment: Alignment.topCenter,
      // The widget to be aligned
      child: this,
    );
  }

  // Aligns the widget to the top-right corner
  Widget alignTopRight() {
    return Align(
      // Set alignment to top-right
      alignment: Alignment.topRight,
      // The widget to be aligned
      child: this,
    );
  }

  // Aligns the widget to the center-left
  Widget alignCenterLeft() {
    return Align(
      // Set alignment to center-left
      alignment: Alignment.centerLeft,
      // The widget to be aligned
      child: this,
    );
  }

  // Aligns the widget to the center
  Widget alignCenter() {
    return Align(
      // Set alignment to center
      alignment: Alignment.center,
      // The widget to be aligned
      child: this,
    );
  }

  // Aligns the widget to the center-right
  Widget alignCenterRight() {
    return Align(
      // Set alignment to center-right
      alignment: Alignment.centerRight,
      // The widget to be aligned
      child: this,
    );
  }

  // Aligns the widget to the bottom-left corner
  Widget alignBottomLeft() {
    return Align(
      // Set alignment to bottom-left
      alignment: Alignment.bottomLeft,
      // The widget to be aligned
      child: this,
    );
  }

  // Aligns the widget to the bottom-center
  Widget alignBottomCenter() {
    return Align(
      // Set alignment to bottom-center
      alignment: Alignment.bottomCenter,
      // The widget to be aligned
      child: this,
    );
  }

  // Aligns the widget to the bottom-right corner
  Widget alignBottomRight() {
    return Align(
      // Set alignment to bottom-right
      alignment: Alignment.bottomRight,
      // The widget to be aligned
      child: this,
    );
  }
}