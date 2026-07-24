import 'package:flutter/material.dart';

class AppTheme {
  // Primary Colors
  // Slightly darker teal shades to better match Figma
  static const Color primaryTeal = Color(0xFF446B6D);
  static const Color primaryDark = Color(0xFF345556);
  static const Color primaryLight = Color(0xFF5A8C8E);
  static const Color appTheme = Color(0xFF587B7F);


  // Secondary Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF5F5F5);
  static const Color lightGray = Color(0xFFFBF9F9);
  static const Color darkGray = Color(0xFF666666);
  static const Color textDark = Color(0xFF1F2023);
  static const Color textMuted = Color(0xFF7A9AA0);

  // Status Colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color errorRed = Color(0xFFE74C3C);
  static const Color warningOrange = Color(0xFFF39C12);

  // Text Styles
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: white,
    height: 1.2,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: white,
    height: 1.2,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: white,
    height: 1.2,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFFD0D0D0),
    height: 1.4,
  );

  static const TextStyle bodyRegular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: white,
    height: 1.4,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xFFD0D0D0),
    height: 1.3,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: white,
  );

  static TextStyle newsreader({
    required double fontSize,
    FontStyle fontStyle = FontStyle.normal,
    FontWeight fontWeight = FontWeight.w400,
    Color color = white,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'Newsreader',
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  static TextStyle dmSans({
    required double fontSize,
    FontStyle fontStyle = FontStyle.normal,
    FontWeight fontWeight = FontWeight.w400,
    Color color = white,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }
}

