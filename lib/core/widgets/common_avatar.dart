import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

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
        border: borderColor != null
            ? Border.all(color: borderColor ?? AppColors.borderGrey)
            : Border.all(width: 0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(size / 2),
        child: Image.network(
          'https://preview.redd.it/what-do-you-like-about-toby-maguires-spider-man-v0-jmobfrotmnlb1.jpg?width=1080&crop=smart&auto=webp&s=676fd6fef512f6334105a4c1018badb052b2a1f6',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
