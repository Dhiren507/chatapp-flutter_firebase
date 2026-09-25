import 'package:flutter/material.dart';

class CommonImageContainer extends StatelessWidget {
  final String imgUrl;
  final double borderRadius;
  final double size;

  const CommonImageContainer({
    super.key,
    required this.imgUrl,
    this.size = 92,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(borderRadius),
        child: Image.network(imgUrl),
      ),
    );
  }
}
