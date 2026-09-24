import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final Color textColor;

  const OrDivider({super.key, this.textColor = AppColors.dividerText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider()),
        const SizedBox(width: 15),
        Text(AppStrings.orText, style: AppTextStyles.body(color: textColor)),
        const SizedBox(width: 15),
        Expanded(child: Divider()),
      ],
    );
  }
}
