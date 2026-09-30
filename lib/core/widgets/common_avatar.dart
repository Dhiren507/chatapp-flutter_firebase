import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAvatar extends StatelessWidget {
  final String imgPath;
  final Color? borderColor;
  final double size;

  const CommonAvatar({
    super.key,
    required this.imgPath,
    this.size = 44,
    this.borderColor = AppColors.borderGrey,
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
        child: CachedNetworkImage(
          imageUrl: imgPath,
          errorWidget: (context, url, error) {
            return SvgPicture.asset(AppAssets.helpIcon, fit: BoxFit.cover);
          },
        ),
      ),
    );
  }
}
