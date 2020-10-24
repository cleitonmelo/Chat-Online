import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData chatAppTheme() => ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.deepPurple,
  accentColor: Colors.purple,
  hintColor: Colors.yellow,
  iconTheme: IconThemeData(
    color: Colors.amber,
  ),
  fontFamily: GoogleFonts.aladin().fontFamily,
);

LinearGradient linearGradientDefault() => LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [HexColor("#690356"), HexColor("#8E0C76")],
);

Widget textTitle(text, {padding, bool alignCenter}) {
  final align = alignCenter ? TextAlign.center : null;
  return simpleText(text, size: 30.0, padding: padding, align: align);
}

Widget textSubtitle(text, {color, padding, alignCenter}) {
  final align = alignCenter ? TextAlign.center : null;
  return simpleText(text, size: 20.0, color: color, align: align);
}

Widget simpleText(text,
    {padding, color, TextAlign align, @required double size}) {
  return Padding(
    padding: padding ?? EdgeInsets.zero,
    child: Text(
      text,
      textAlign: align ?? TextAlign.left,
      style: GoogleFonts.abel(
          fontWeight: FontWeight.bold,
          fontSize: size,
          color: color ?? Colors.white,
          decoration: TextDecoration.none),
    ),
  );
}