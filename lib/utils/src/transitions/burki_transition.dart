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

    Created by Muhammad Atif on 4/26/2024.
    Portfolio https://atifnoori.web.app.
    IsloAI

 *********************************************************************************/

import 'package:flutter/material.dart';

/// Enum representing different types of transitions that can be applied to UI elements.
enum BurkiTransitionType {
  /// A slide transition, where the element slides into or out of view.
  slide,

  /// A fade transition, where the element's opacity is gradually increased or decreased.
  fade,

  /// A scale transition, where the element's size is increased or decreased.
  scale,

  /// A rotate transition, where the element is rotated by a certain angle.
  rotate,

  /// A flip transition, where the element is flipped horizontally or vertically.
  flip,

  /// A zoom-in transition, where the element's size is increased to a larger scale.
  zoomIn,

  /// A zoom-out transition, where the element's size is decreased to a smaller scale.
  zoomOut,

  /// A spin transition, where the element rotates continuously.
  spin,

  /// A grow transition, where the element's size is increased.
  grow,

  /// A shrink transition, where the element's size is decreased.
  shrink,

  /// A slide-up transition, where the element slides upwards into or out of view.
  slideUp,

  /// A slide-down transition, where the element slides downwards into or out of view.
  slideDown,

  /// A slide-left transition, where the element slides left into or out of view.
  slideLeft,

  /// A slide-right transition, where the element slides right into or out of view.
  slideRight,

  /// A rotate-and-scale transition, where the element is rotated and scaled simultaneously.
  rotateAndScale,
}

/// A custom stateful widget that provides a transition effect to its child widget.
class BurkiTransition extends StatefulWidget {
  // The child widget to which the transition effect will be applied.
  final Widget child;

  // The duration of the transition effect. Defaults to 1 second if not provided.
  final Duration duration;

  // The type of transition effect to be applied. Defaults to fade if not provided.
  final BurkiTransitionType burkiTransitionType;

  // The number of times the transition effect should be repeated. Defaults to 1 if not provided.
  final int repeat;

  // Constructor for the NooriTransition widget.
  const BurkiTransition({
    // The key for the widget, inherited from the superclass.
    super.key,

    // The required child widget.
    required this.child,

    // The duration of the transition effect, with a default value of 1 second.
    this.duration = const Duration(seconds: 1),

    // The type of transition effect, with a default value of fade.
    this.burkiTransitionType = BurkiTransitionType.fade,

    // The number of times the transition effect should be repeated, with a default value of 1.
    this.repeat = 1,
  });

  // Creates the state for the NooriTransition widget.
  @override
  State<BurkiTransition> createState() => _BurkiTransitionState();
}

class _BurkiTransitionState extends State<BurkiTransition>
    with SingleTickerProviderStateMixin {
  // Declare a late initialized AnimationController, which will be used to control the animation
  late AnimationController _controller;

  // Declare a late initialized Animation of type double, which will be used to animate a value
  late Animation<double> _animation;

  // Declare a late initialized Animation of type double, which will be used to animate a scale value
  late Animation<double> _scaleAnimation;

  // Initialize a variable to keep track of the current repeat count of the animation
  int _currentRepeat = 0;

  // Initialize a boolean flag to indicate whether the animation is currently playing forward or not
  bool _isForward = true;

  @override
  void initState() {
    // Call the superclasses initState method to ensure proper initialization
    super.initState();

    // Create an AnimationController with the specified duration and vsync
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Determine the type of animation based on the widget's transition type
    switch (widget.burkiTransitionType) {
      case BurkiTransitionType.slide:
        // Create a Tween animation for sliding transitions
        _animation = Tween<double>(begin: _isForward ? -1.0 : 1.0, end: 0.0)
            .animate(_controller);
        break;
      case BurkiTransitionType.fade:
        // Create a Tween animation for fading transitions
        _animation = Tween<double>(
                begin: _isForward ? 0.0 : 1.0, end: _isForward ? 1.0 : 0.0)
            .animate(_controller);
        break;
      case BurkiTransitionType.scale:
        // Create a Tween animation for scaling transitions
        _animation = Tween<double>(
                begin: _isForward ? 0.0 : 1.0, end: _isForward ? 1.0 : 0.0)
            .animate(_controller);
        break;
      case BurkiTransitionType.rotate:
        // Create a Tween animation for rotating transitions
        _animation =
            Tween<double>(begin: 0.0, end: 3.14 * 2).animate(_controller);
        break;
      case BurkiTransitionType.flip:
        // Create a Tween animation for flipping transitions
        _animation = Tween<double>(begin: 0.0, end: 3.14).animate(_controller);
        break;
      case BurkiTransitionType.zoomIn:
        // Create a Tween animation for zooming in transitions
        _animation = Tween<double>(
                begin: _isForward ? 0.0 : 1.0, end: _isForward ? 1.0 : 0.0)
            .animate(_controller);
        break;
      case BurkiTransitionType.zoomOut:
        // Create a Tween animation for zooming out transitions
        _animation = Tween<double>(
                begin: _isForward ? 1.0 : 0.0, end: _isForward ? 0.0 : 1.0)
            .animate(_controller);
        break;
      case BurkiTransitionType.spin:
        // Create a Tween animation for spinning transitions
        _animation =
            Tween<double>(begin: 0.0, end: 3.14 * 2).animate(_controller);
        break;
      case BurkiTransitionType.grow:
        // Create a Tween animation for growing transitions
        _animation = Tween<double>(
                begin: _isForward ? 0.0 : 1.0, end: _isForward ? 1.0 : 0.0)
            .animate(_controller);
        break;
      case BurkiTransitionType.shrink:
        // Create a Tween animation for shrinking transitions
        _animation = Tween<double>(
                begin: _isForward ? 1.0 : 0.0, end: _isForward ? 0.0 : 1.0)
            .animate(_controller);
        break;
      case BurkiTransitionType.slideUp:
        // Create a Tween animation for sliding up transitions
        _animation = Tween<double>(begin: _isForward ? 1.0 : -1.0, end: 0.0)
            .animate(_controller);
        break;
      case BurkiTransitionType.slideDown:
        // Create a Tween animation for sliding down transitions
        _animation = Tween<double>(begin: _isForward ? -1.0 : 1.0, end: 0.0)
            .animate(_controller);
        break;
      case BurkiTransitionType.slideLeft:
        // Create a Tween animation for sliding left transitions
        _animation = Tween<double>(begin: _isForward ? 1.0 : -1.0, end: 0.0)
            .animate(_controller);
        break;
      case BurkiTransitionType.slideRight:
        // Create a Tween animation for sliding right transitions
        _animation = Tween<double>(begin: _isForward ? -1.0 : 1.0, end: 0.0)
            .animate(_controller);
        break;
      case BurkiTransitionType.rotateAndScale:
        // Create a Tween animation for rotating and scaling transitions
        _animation =
            Tween<double>(begin: 0.0, end: 3.14 * 2).animate(_controller);
        // Create a separate Tween animation for scaling
        _scaleAnimation = Tween<double>(
                begin: _isForward ? 0.0 : 1.0, end: _isForward ? 1.0 : 0.0)
            .animate(_controller);
        break;
    }

    // Add a status listener to the animation controller
    _controller.addStatusListener((status) {
      // Check if the animation has completed
      if (status == AnimationStatus.completed) {
        // Toggle the _isForward flag
        _isForward = !_isForward;
        // Increment the repeat count
        _currentRepeat++;
        // Check if the animation should repeat
        if (widget.repeat == 0 || _currentRepeat < widget.repeat) {
          // Reset the animation controller
          _controller.reset();
          // Start the animation again
          _controller.forward();
        }
      }
    });

    // Start the animation
    _controller.forward();
  }

  @override
  // This method is responsible for building the widget tree.
  Widget build(BuildContext context) {
    // Create an AnimatedBuilder widget that rebuilds its child when the animation changes.
    return AnimatedBuilder(
      // The animation that triggers the rebuild.
      animation: _controller,
      // A function that builds the child widget.
      builder: (context, child) {
        // Depending on the transition type, apply different animations to the child widget.
        switch (widget.burkiTransitionType) {
          case BurkiTransitionType.slide:
            // Slide the child widget from left to right.
            return Transform.translate(
              // Calculate the offset based on the animation value and screen width.
              offset: Offset(
                  _animation.value * MediaQuery.of(context).size.width, 0.0),
              // Make the child widget fully opaque.
              child: Opacity(
                opacity: 1.0,
                child: widget.child,
              ),
            );
          case BurkiTransitionType.fade:
            // Fade the child widget in or out.
            return Opacity(
              // Set the opacity based on the animation value.
              opacity: _animation.value,
              child: widget.child,
            );
          case BurkiTransitionType.scale:
            // Scale the child widget up or down.
            return Transform.scale(
              // Set the scale factor based on the animation value.
              scale: _animation.value,
              child: widget.child,
            );
          case BurkiTransitionType.rotate:
            // Rotate the child widget.
            return Transform.rotate(
              // Set the rotation angle based on the animation value.
              angle: _animation.value,
              child: widget.child,
            );
          case BurkiTransitionType.flip:
            // Flip the child widget around the x-axis.
            return Transform(
              // Create a 3D transformation matrix.
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(_animation.value),
              // Center the child widget.
              alignment: Alignment.center,
              child: widget.child,
            );
          case BurkiTransitionType.zoomIn:
            // Zoom the child widget in.
            return Transform.scale(
              // Set the scale factor based on the animation value.
              scale: _animation.value,
              child: widget.child,
            );
          case BurkiTransitionType.zoomOut:
            // Zoom the child widget out.
            return Transform.scale(
              // Set the scale factor based on the animation value.
              scale: _animation.value,
              child: widget.child,
            );
          case BurkiTransitionType.spin:
            // Spin the child widget around its center.
            return Transform.rotate(
              // Set the rotation angle based on the animation value.
              angle: _animation.value,
              child: widget.child,
            );
          case BurkiTransitionType.grow:
            // Grow the child widget from its center.
            return Transform.scale(
              // Set the scale factor based on the animation value.
              scale: _animation.value,
              // Center the child widget.
              alignment: Alignment.center,
              child: widget.child,
            );
          case BurkiTransitionType.shrink:
            // Shrink the child widget from its center.
            return Transform.scale(
              // Set the scale factor based on the animation value.
              scale: _animation.value,
              // Center the child widget.
              alignment: Alignment.center,
              child: widget.child,
            );
          case BurkiTransitionType.slideUp:
            // Slide the child widget up.
            return Transform.translate(
              // Calculate the offset based on the animation value and screen height.
              offset: Offset(
                  0.0, _animation.value * MediaQuery.of(context).size.height),
              child: widget.child,
            );
          case BurkiTransitionType.slideDown:
            // Slide the child widget down.
            return Transform.translate(
              // Calculate the offset based on the animation value and screen height.
              offset: Offset(
                  0.0, _animation.value * MediaQuery.of(context).size.height),
              child: widget.child,
            );
          case BurkiTransitionType.slideLeft:
            // Slide the child widget to the left.
            return Transform.translate(
              // Calculate the offset based on the animation value and screen width.
              offset: Offset(
                  _animation.value * MediaQuery.of(context).size.width, 0.0),
              child: widget.child,
            );
          case BurkiTransitionType.slideRight:
            // Slide the child widget to the right.
            return Transform.translate(
              // Calculate the offset based on the animation value and screen width.
              offset: Offset(
                  _animation.value * MediaQuery.of(context).size.width, 0.0),
              child: widget.child,
            );
          case BurkiTransitionType.rotateAndScale:
            // Rotate and scale the child widget simultaneously.
            return Transform.scale(
              // Set the scale factor based on the _scaleAnimation value.
              scale: _scaleAnimation.value,
              child: Transform.rotate(
                // Set the rotation angle based on the _animation value.
                angle: _animation.value,
                child: widget.child,
              ),
            );
          default:
            // Return an empty container if the transition type is not recognized.
            return Container();
        }
      },
    );
  }

  /// Releases the resources used by this object, such as the animation controller.
  /// This method is typically called when the object is no longer needed.
  @override
  void dispose() {
    // Dispose of the animation controller to free up system resources
    _controller.dispose();
    // Call the superclasses dispose method to ensure any additional resources are released
    super.dispose();
  }
}
