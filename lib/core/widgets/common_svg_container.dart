import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonSvgContainer extends StatelessWidget {
  final String? iconPath;
  final double? iconSize;
  final Color? iconColor;
  final Color? backgroundColor;
  final double containerSize;
  final Color? borderColor;
  final VoidCallback? onClick;

  const CommonSvgContainer({
    super.key,
    this.iconPath,
    this.iconSize,
    this.backgroundColor,
    required this.containerSize,
    this.iconColor,
    this.borderColor,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: containerSize,
        width: containerSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: borderColor != null
              ? Border.all(color: borderColor ?? AppColors.borderGrey)
              : Border.all(width: 0, color: Colors.transparent),
          color: backgroundColor ?? Colors.transparent,
        ),
        child: Center(
          child: iconPath != null && iconPath!.isNotEmpty
              ? SizedBox(
                  height: iconSize,
                  width: iconSize,
                  child: SvgPicture.asset(
                    iconPath!,
                    fit: BoxFit.contain,
                    colorFilter: iconColor != null ? ColorFilter.mode(iconColor!, BlendMode.srcIn) : null,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
