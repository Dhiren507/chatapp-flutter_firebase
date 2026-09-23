import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonAvatar extends StatelessWidget {
  String imgPath;
  Color? borderColor;
  double size;

  CommonAvatar({
    super.key,
    required this.imgPath,
    this.size = 44,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? AppColors.borderGrey,
        ),
      ),
      child: SvgPicture.asset(AppAssets.contactIcon, fit: BoxFit.cover),
    );
  }
}
