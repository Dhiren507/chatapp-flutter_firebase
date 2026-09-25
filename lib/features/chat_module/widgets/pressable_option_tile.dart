import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PressableOptionTile extends StatelessWidget {
  VoidCallback onPressed;
  String iconPath;
  String optionTitle;
  String? optionDescription;

  PressableOptionTile({
    super.key,
    required this.iconPath,
    required this.optionTitle,
    this.optionDescription,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: AppColors.bgGrey,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              iconPath,
              height: 16,
              width: 16,
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(optionTitle, style: AppTextStyles.heading()),
              if (optionDescription != null && optionDescription != '')
                Text(optionDescription!, style: AppTextStyles.body()),
            ],
          ),
        ],
      ),
    );
  }
}
