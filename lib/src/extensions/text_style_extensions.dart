import 'package:flutter/widgets.dart';

extension TxtStyle on TextStyle {
  /// The most thick - FontWeight.w900
  TextStyle get mostThick => copyWith(fontWeight: FontWeight.w900);

  /// Extra-bold - FontWeight.w800
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);

  /// Bold - FontWeight.bold - FontWeight.w700
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  /// Semi-bold - FontWeight.w600
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  /// Medium - FontWeight.w500
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  /// Regular - FontWeight.w400
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  /// Light - FontWeight.w300
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  /// Extra-light - FontWeight.w200
  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);

  /// Thin, the least thick - FontWeight.w100
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);
}
