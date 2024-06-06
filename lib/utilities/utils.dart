import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Primary and Secondary Texts
class AppFonts {
  static TextStyle primaryText(BuildContext context) {
    return GoogleFonts.rethinkSans(
      textStyle: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static TextStyle secondaryText(BuildContext context) {
    return GoogleFonts.rethinkSans(
      textStyle: TextStyle(
        fontSize: 14,
        color: Color(0xff39FF14),
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

//Custom Textstyle
TextStyle fontStyle(double size, Color color, FontWeight fw) {
  return GoogleFonts.rethinkSans(
    fontSize: size,
    color: color,
    fontWeight: fw,
  );
}



