import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonImageContainer extends StatelessWidget {
  String? iconPath;
  double? iconSize;
  Color? iconColor;
  Color? backgroundColor;
  double containerSize;
  Color? borderColor;

  CommonImageContainer({
    super.key,
    this.iconPath,
    this.iconSize,
    this.backgroundColor,
    required this.containerSize,
    this.iconColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerSize,
      width: containerSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? AppColors.borderGrey,
          width: 1,
        ),
        color: backgroundColor ?? Colors.transparent,
      ),
      child: SvgPicture.asset(
        iconPath ?? '',
        height: iconSize,
        width: iconSize,
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(
          iconColor ?? AppColors.black,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
