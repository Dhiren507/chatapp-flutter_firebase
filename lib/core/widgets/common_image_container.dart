import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CommonImageContainer extends StatelessWidget {
  final String imgUrl;
  final double borderRadius;
  final Color borderColor;
  final double size;
  final BoxFit fit;

  const CommonImageContainer({
    super.key,
    required this.imgUrl,
    this.size = 92,
    this.borderRadius = 8,
    this.borderColor = AppColors.lightGray,
    this.fit = .contain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        // border: Border.all(color: borderColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(imageUrl: imgUrl, fit: fit),
      ),
    );
  }
}
