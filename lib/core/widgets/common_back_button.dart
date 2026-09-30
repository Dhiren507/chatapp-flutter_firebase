import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonBackButton extends StatelessWidget {
  final Color? arrowColor;

  const CommonBackButton({super.key, this.arrowColor = AppColors.black});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: AppColors.textPrimary,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
      icon: SvgPicture.asset(
        AppAssets.backArrow,
        height: 16,
        width: 20,
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(arrowColor!, BlendMode.srcIn),
      ),
      onPressed: () {
        Navigator.maybePop(context);
      },
    );
  }
}
