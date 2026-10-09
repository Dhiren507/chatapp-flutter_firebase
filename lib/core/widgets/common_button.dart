import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class CommonButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double borderRadius;
  final Color backgroundColor;
  final Color textColor;
  final double? elevation;
  final bool isLoading;

  const CommonButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.borderRadius = 16,
    this.backgroundColor = AppColors.white,
    this.textColor = AppColors.textPrimary,
    this.elevation,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: AppColors.bgDisables,
          disabledForegroundColor: AppColors.textSecondary,
          elevation: elevation ?? 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        ),
        child: isLoading == true
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(color: AppColors.white),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  label,
                  style: AppTextStyles.heading(fontWeight: FontWeight.w600, color: textColor),
                ),
              ),
      ),
    );
  }
}
