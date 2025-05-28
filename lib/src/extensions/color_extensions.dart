import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color kOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0,
        'Opacity must be between 0.0 and 1.0');
    return withAlpha((255 * opacity).round());
  }
}
