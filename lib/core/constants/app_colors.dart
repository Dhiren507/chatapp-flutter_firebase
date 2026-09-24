import 'dart:ui';

class AppColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF000E08);
  static const Color textSecondary = Color(0xFF797C7B);
  static const Color highlightYellow = Color(0xFFFFC746);

  static const Color errorText = Color(0xFFFF2D1B);
  static const Color bgError = Color(0xFFF04A4C);

  static const Color bgGreen = Color(0xFF20A090);
  static const Color bgGrey = Color(0xFFF2F8F7);
  static const Color bgDisables = Color(0xFFF3F6F6);

  static const Color lightGreen = Color(0xFF2BEF83);
  static const Color green = Color(0xFF24786D);
  static const Color activeGreen = Color(0xFF0FE16D);
  static const Color lightBlack = Color(0xFF001815);
  static const Color lightGray = Color(0xFFB9C1BE);

  static const Color borderGrey = Color(0xFFA8B0AF);
  static const Color dividerColor = Color(0xFFCDD1D0);
  static const Color dividerText = Color(0xFFD6E4E0);
  static const Color mutedGrey = Color(0xFFE6E6E6);
  static const Color colorMutedGreyDark = Color(0xFF989E9C);

  /// Transparent tinted green — used as chip/tag background
  static final Color bgGreenLight = const Color(0xFF20A090).withAlpha(20);

  /// Border color for dotted borders (add-member circle, etc.)
  static const Color dottedBorderGrey = Color(0xFFCFD3D2);
}
