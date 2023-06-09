import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const defaultTimeout = Duration(seconds: 10);

TextStyle defaultTextStyle({
  required Color color,
  TextDecoration decoration = TextDecoration.none,
  FontWeight fontWeight = FontWeight.w500,
  double size = 16,
  double? letterSpacing,
}) =>
    GoogleFonts.getFont(
      'Quicksand',
      textStyle: TextStyle(
        decoration: decoration,
        color: color,
        fontWeight: fontWeight,
        fontSize: size,
        letterSpacing: letterSpacing,
      ),
    );
