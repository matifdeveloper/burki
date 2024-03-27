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

import 'package:burki/utils/src/navigation/transitions.dart';
import 'package:flutter/material.dart';

enum Transition {
  leftToRight,
  rightToLeft,
  bottomToTop,
  topToBottom,
  fadeTransition,
  scaleTransition,
  rotateTransition,
  sizeTransition,
  diagonalTopLeftToBottomRight,
  diagonalBottomRightToTopLeft,
  diagonalTopRightToBottomLeft,
  diagonalBottomLeftToTopRight,
  rotateAndScaleTransition,
  fadeAndScaleTransition,
  slideAndFadeTransition,
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
            return AnimatedTransitions.leftToRight(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.rightToLeft:
            return AnimatedTransitions.rightToLeft(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.bottomToTop:
            return AnimatedTransitions.bottomToTop(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.topToBottom:
            return AnimatedTransitions.topToBottom(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.fadeTransition:
            return AnimatedTransitions.fadeTransition(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.scaleTransition:
            return AnimatedTransitions.scaleTransition(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.rotateTransition:
            return AnimatedTransitions.rotateTransition(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.sizeTransition:
            return AnimatedTransitions.sizeTransition(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.diagonalTopLeftToBottomRight:
            return AnimatedTransitions.diagonalTopLeftToBottomRight(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.diagonalBottomRightToTopLeft:
            return AnimatedTransitions.diagonalBottomRightToTopLeft(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.diagonalTopRightToBottomLeft:
            return AnimatedTransitions.diagonalTopRightToBottomLeft(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.diagonalBottomLeftToTopRight:
            return AnimatedTransitions.diagonalBottomLeftToTopRight(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.rotateAndScaleTransition:
            return AnimatedTransitions.rotateAndScaleTransition(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.fadeAndScaleTransition:
            return AnimatedTransitions.fadeAndScaleTransition(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          case Transition.slideAndFadeTransition:
            return AnimatedTransitions.slideAndFadeTransition(
              context,
              animation,
              secondaryAnimation,
              child,
            );
          default:
            return AnimatedTransitions.leftToRight(
              context,
              animation,
              secondaryAnimation,
              child,
            );
        }
      },
    );
  }
}
