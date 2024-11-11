import 'package:dit/utilities/colors.dart';
import 'package:flutter/material.dart';

extension FigmaDimention on double {
  double toFigmaHeight(double fontSize) {
    return this / fontSize;
  }
}

class BaseFonts {
  static const fontW800 = "PlusJakartaSansExtraBold";
  static const fontW700 = "PlusJakartaSansBold";
  static const fontW650 = "PlusJakartaSansSemiBold";
  static const fontW600 = "PlusJakartaSansMedium";
  static const fontW500 = "PlusJakartaSansRegular";
}

class TStyle {
  static List<Shadow> shadows = <Shadow>[
    const Shadow(
      offset: Offset(0, 0),
      blurRadius: 3.0,
      color: BaseColor.black,
    ),
  ];

  static TextStyle poster = const TextStyle(
      fontFamily: BaseFonts.fontW700, fontSize: 20, color: BaseColor.black);
  static const TextStyle regular12 = TextStyle(
      fontFamily: BaseFonts.fontW500, fontSize: 12, color: BaseColor.black);
  static const TextStyle regular10 = TextStyle(
      fontFamily: BaseFonts.fontW500, fontSize: 10, color: BaseColor.black);
  static const TextStyle regular14 = TextStyle(
      fontFamily: BaseFonts.fontW500, fontSize: 14, color: BaseColor.black);
  static const TextStyle regular16 = TextStyle(
      fontFamily: BaseFonts.fontW500, fontSize: 16, color: BaseColor.black);
  static const TextStyle regular20 = TextStyle(
      fontFamily: BaseFonts.fontW500, fontSize: 20, color: BaseColor.black);
  static const TextStyle regular24 = TextStyle(
      fontFamily: BaseFonts.fontW500, fontSize: 24, color: BaseColor.black);
  static const TextStyle regular36 = TextStyle(
      fontFamily: BaseFonts.fontW500, fontSize: 36, color: BaseColor.black);
  static const TextStyle regular32 = TextStyle(
      fontFamily: BaseFonts.fontW500, fontSize: 32, color: BaseColor.black);

  static const TextStyle medium11 = TextStyle(
      fontFamily: BaseFonts.fontW600, fontSize: 11, color: BaseColor.black);
  static const TextStyle medium12 = TextStyle(
      fontFamily: BaseFonts.fontW600, fontSize: 12, color: BaseColor.black);
  static const TextStyle medium14 = TextStyle(
      fontFamily: BaseFonts.fontW600, fontSize: 14, color: BaseColor.black);
  static const TextStyle medium16 = TextStyle(
      fontFamily: BaseFonts.fontW600, fontSize: 16, color: BaseColor.black);
  static const TextStyle medium20 = TextStyle(
      fontFamily: BaseFonts.fontW600, fontSize: 20, color: BaseColor.black);
  static const TextStyle medium24 = TextStyle(
      fontFamily: BaseFonts.fontW600, fontSize: 24, color: BaseColor.black);
  static const TextStyle medium32 = TextStyle(
      fontFamily: BaseFonts.fontW600, fontSize: 32, color: BaseColor.black);
  static const TextStyle medium36 = TextStyle(
      fontFamily: BaseFonts.fontW600, fontSize: 36, color: BaseColor.black);
  static const TextStyle medium64 = TextStyle(
      fontFamily: BaseFonts.fontW600, fontSize: 64, color: BaseColor.black);

  static const TextStyle semiBold8 = TextStyle(
      fontFamily: BaseFonts.fontW650, fontSize: 8, color: BaseColor.black);
  static const TextStyle semiBold12 = TextStyle(
      fontFamily: BaseFonts.fontW650, fontSize: 12, color: BaseColor.black);
  static const TextStyle semiBold14 = TextStyle(
      fontFamily: BaseFonts.fontW650, fontSize: 14, color: BaseColor.black);
  static const TextStyle semiBold16 = TextStyle(
      fontFamily: BaseFonts.fontW650, fontSize: 16, color: BaseColor.black);
  static const TextStyle semiBold20 = TextStyle(
      fontFamily: BaseFonts.fontW650, fontSize: 20, color: BaseColor.black);
  static const TextStyle semiBold24 = TextStyle(
      fontFamily: BaseFonts.fontW650, fontSize: 24, color: BaseColor.black);
  static const TextStyle semiBold36 = TextStyle(
      fontFamily: BaseFonts.fontW650, fontSize: 36, color: BaseColor.black);

  static const TextStyle bold8 = TextStyle(
      fontFamily: BaseFonts.fontW700, fontSize: 10, color: BaseColor.black);
  static const TextStyle bold12 = TextStyle(
      fontFamily: BaseFonts.fontW700, fontSize: 12, color: BaseColor.black);
  static const TextStyle bold14 = TextStyle(
      fontFamily: BaseFonts.fontW700, fontSize: 14, color: BaseColor.black);
  static const TextStyle bold16 = TextStyle(
      fontFamily: BaseFonts.fontW700, fontSize: 16, color: BaseColor.black);
  static const TextStyle bold20 = TextStyle(
      fontFamily: BaseFonts.fontW700, fontSize: 20, color: BaseColor.black);
  static const TextStyle bold24 = TextStyle(
      fontFamily: BaseFonts.fontW700, fontSize: 24, color: BaseColor.black);
  static const TextStyle bold36 = TextStyle(
      fontFamily: BaseFonts.fontW700, fontSize: 36, color: BaseColor.black);
  static const TextStyle bold32 = TextStyle(
      fontFamily: BaseFonts.fontW700, fontSize: 32, color: BaseColor.black);
  static const TextStyle bold74 = TextStyle(
      fontFamily: BaseFonts.fontW700, fontSize: 74, color: BaseColor.black);

  static const TextStyle extraBold12 = TextStyle(
      fontFamily: BaseFonts.fontW800, fontSize: 12, color: BaseColor.black);
  static const TextStyle extraBold14 = TextStyle(
      fontFamily: BaseFonts.fontW800, fontSize: 14, color: BaseColor.black);
  static const TextStyle extraBold16 = TextStyle(
      fontFamily: BaseFonts.fontW800, fontSize: 16, color: BaseColor.black);
  static const TextStyle extraBold20 = TextStyle(
      fontFamily: BaseFonts.fontW800, fontSize: 20, color: BaseColor.black);
  static const TextStyle extraBold24 = TextStyle(
      fontFamily: BaseFonts.fontW800, fontSize: 24, color: BaseColor.black);
  static const TextStyle extraBold36 = TextStyle(
      fontFamily: BaseFonts.fontW800, fontSize: 36, color: BaseColor.black);
  static const TextStyle extraBold74 = TextStyle(
      fontFamily: BaseFonts.fontW800, fontSize: 74, color: BaseColor.black);
}
