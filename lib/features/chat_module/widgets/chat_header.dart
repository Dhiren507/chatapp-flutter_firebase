import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:flutter/material.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          clipBehavior: .none,
          children: [
            CommonAvatar(
              imgPath: AppAssets.appleIcon,
              size: 44,
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

        const SizedBox(width: 10),

        Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'John Abraham',
              style: AppTextStyles.heading(fontSize: 16),
              overflow: .ellipsis,
            ),
            Text('Active Now', style: AppTextStyles.body(fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
