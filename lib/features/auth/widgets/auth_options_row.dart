import 'dart:io';

import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';

class AuthOptionsRow extends StatelessWidget {
  const AuthOptionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      spacing: 20,
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderGrey, width: 1),
          ),
          child: SvgPicture.asset(
            AppAssets.facebookIcon,
            height: 24,
            width: 24,
            fit: BoxFit.scaleDown,
          ),
        ),
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderGrey, width: 1),
          ),
          child: SvgPicture.asset(
            AppAssets.googleIcon,
            height: 24,
            width: 24,
            fit: BoxFit.scaleDown,
          ),
        ),
        if (Platform.isIOS)
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderGrey, width: 1),
            ),
            child: SvgPicture.asset(
              AppAssets.appleIcon,
              height: 24,
              width: 24,
              fit: BoxFit.scaleDown,
            ),
          ),
      ],
    );
  }
}
