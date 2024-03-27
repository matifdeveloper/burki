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

enum Transition {
  leftToRight,
  rightToLeft,
  bottomToTop,
  topToBottom,
  fadeTransition,
  scaleTransition,
}

class Navigate {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get currentContext =>
      navigatorKey.currentState!.overlay!.context;

  /// Move from the current route
  Navigate.to(Widget screen, {Transition? transition}) {
    navigatorKey.currentState!.push(
      transition != null
          ? pageRouteBuilder(screen, transition)
          : MaterialPageRoute(
              builder: (_) => screen,
            ),
    );
  }

  /// Replace the current route with new on
  Navigate.off(Widget screen, {Transition? transition}) {
    navigatorKey.currentState!.pushReplacement(
      transition != null
          ? pageRouteBuilder(screen, transition)
          : MaterialPageRoute(
              builder: (_) => screen,
            ),
    );
  }

  /// Remove all the routes
  Navigate.offAll(Widget screen, {Transition? transition}) {
    navigatorKey.currentState!.pushAndRemoveUntil(
      transition != null
          ? pageRouteBuilder(screen, transition)
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
  PageRouteBuilder pageRouteBuilder(Widget screen, Transition transition) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transition) {
          case Transition.leftToRight:
            return leftToRight(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.rightToLeft:
            return rightToLeft(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.bottomToTop:
            return bottomToTop(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.topToBottom:
            return topToBottom(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.fadeTransition:
            return fadeTransition(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.scaleTransition:
            return scaleTransition(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          default:
            return leftToRight(
              context,
              animation,
              secondaryAnimation,
              child,
            );
        }
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

  /// Slide transition from right to left
  SlideTransition rightToLeft(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(-1.0, 0.0);
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


  /// Slide transition from bottom to top
  SlideTransition bottomToTop(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(0.0, 1.0);
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

  /// Slide transition from top to bottom
  SlideTransition topToBottom(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(0.0, -1.0);
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

  /// Fade transition
  FadeTransition fadeTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  /// Scale transition
  ScaleTransition scaleTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }
}
