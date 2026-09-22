import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const _fontCaros = 'Caros';
  static const _fontCircular = 'CircularStd';

  static TextStyle body({
    String fontFamily = _fontCircular,
    Color color = AppColors.textSecondary,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    FontStyle fontStyle = FontStyle.normal,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle heading({
    String fontFamily = _fontCaros,
    Color color = AppColors.textPrimary,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w500,
    FontStyle fontStyle = FontStyle.normal,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      height: height,
      letterSpacing: letterSpacing,
    );
  }






}
