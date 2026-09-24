import 'package:flutter/material.dart';

class CommonImageContainer extends StatelessWidget {
  String imgUrl;
  Color? borderColor;
  double size;

  CommonImageContainer({
    super.key,
    required this.imgUrl,
    this.size = 92,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(16),
        child: Image.network(imgUrl),
      ),
    );
  }
}
