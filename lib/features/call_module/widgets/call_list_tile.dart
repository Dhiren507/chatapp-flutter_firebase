import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CallListTile extends StatelessWidget {
  const CallListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          clipBehavior: .none,
          children: [
            CommonAvatar(
              imgPath: AppAssets.appleIcon,
              size: 55,
              borderColor: Colors.transparent,
            ),
            Positioned(
              bottom: -0,
              right: 5,
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: AppColors.activeGreen,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                'John Abraham',
                style: AppTextStyles.heading(fontSize: 18),
                overflow: .ellipsis,
              ),
              Row(
                spacing: 3,
                children: [
                  SvgPicture.asset(
                    AppAssets.incomingCallIcon,
                    height: 16,
                    width: 16,
                    fit: BoxFit.scaleDown,
                  ),
                  Text(
                    'Today, 09:30 AM',
                    style: AppTextStyles.body(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),

        Row(
          spacing: 10,
          children: [
            CommonSvgContainer(
              containerSize: 32,
              iconPath: AppAssets.callIcon,
              borderColor: Colors.transparent,
              iconSize: 24,
              iconColor: AppColors.colorMutedGreyDark,
            ),
            CommonSvgContainer(
              containerSize: 32,
              iconPath: AppAssets.videoIcon,
              borderColor: Colors.transparent,
              iconSize: 24,
              iconColor: AppColors.colorMutedGreyDark,
            ),
          ],
        ),
      ],
    );
  }
}
