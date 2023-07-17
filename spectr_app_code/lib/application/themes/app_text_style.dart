import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyle {
  static const button = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontFamily: 'inter',
      height: 1.4285714286,
      letterSpacing: 0.0,
      color: Colors.black45);

  static const startText = TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontFamily: 'inter',
      height: 1.4285714286,
      letterSpacing: 0.0,
      color: Colors.white);

  static const logoText = TextStyle(
    fontSize: 75,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontFamily: 'seoulnamsan',
    //height: 1.4285714286,
    //letterSpacing: 0.0,
  );
}
