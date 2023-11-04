import 'package:firebase_todo/core/color/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

gfontsubtitlefont(
    {double sz = 16,
    double ls = 0,
    FontWeight fw = FontWeight.normal,
    Color cl = Apc.black}) {
  return GoogleFonts.amaranth(
    fontSize: sz,
    letterSpacing: ls,
    fontWeight: fw,
    color: cl,
  );
}

class FontFamily {
  static String fontName = "BComfort";
}

class TextStyleBuilder {
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final String? fontFamily;

  TextStyleBuilder({
    this.fontSize,
    this.fontWeight,
    this.fontColor,
    this.fontFamily,
  });

  TextStyle build() {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: fontColor,
      fontFamily: fontFamily,
    );
  }
}

class K2DFonts {
  static TextStyle regular({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return GoogleFonts.k2d(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle bold({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    double? spacing,
  }) {
    return GoogleFonts.k2d(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.bold,
        height: height,
        color: color,
        wordSpacing: spacing,
        letterSpacing: letterSpacing);
  }

  static TextStyle medium({
    double? fontSize,
    Color? color,
    double? height,
    FontWeight? fontWeight,
    double? letterSpacing,
  }) {
    return GoogleFonts.k2d(
        fontSize: fontSize,
        height: height,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color,
        letterSpacing: letterSpacing);
  }
}
