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

class Navigate {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get currentContext =>
      navigatorKey.currentState!.overlay!.context;

  /// Move from the current route
  Navigate.to(Widget screen, {bool isAnimated = false}) {
    navigatorKey.currentState!.push(
      isAnimated
          ? pageRouteBuilder(screen)
          : MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }

  /// Replace the current route with new on
  Navigate.off(Widget screen, {bool isAnimated = false}) {
    navigatorKey.currentState!.pushReplacement(
      isAnimated
          ? pageRouteBuilder(screen)
          : MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }

  /// Remove all the routes
  Navigate.offAll(Widget screen, {bool isAnimated = false}) {
    navigatorKey.currentState!.pushAndRemoveUntil(
      isAnimated
          ? pageRouteBuilder(screen)
          : MaterialPageRoute(
        builder: (_) => screen,
      ),
          (context) => false,
    );
  }

  Navigate.back({dynamic result}) {
    navigatorKey.currentState!.pop(result);
  }

  /// This is our page route Builder with animation
  PageRouteBuilder pageRouteBuilder(Widget screen) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return leftToRight(context, animation, secondaryAnimation, child);
      },
    );
  }

  ///Animation method to left to right
  SlideTransition leftToRight(context, animation, secondaryAnimation, child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOutSine;
    final tween = Tween(begin: begin, end: end);
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
    );
    return SlideTransition(
      position: tween.animate(curvedAnimation),
      child: child,
    );
  }
}
