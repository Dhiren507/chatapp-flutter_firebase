import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:flutter/material.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({super.key});

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
                'Alex Linderson no way home how are you doing this lol',
                style: AppTextStyles.heading(fontSize: 20),
                overflow: .ellipsis,
              ),
              Text(
                'Hellow how are you doing this no way home how are you freaking doing this lol',
                style: AppTextStyles.body(fontSize: 12),
                overflow: .ellipsis,
              ),
            ],
          ),
        ),

        Column(
          crossAxisAlignment: .end,
          children: [
            Text('2 min ago', style: AppTextStyles.body()),
            Container(
              height: 22,
              width: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.bgError,
                shape: BoxShape.circle,
              ),
              child: Text(
                '3',
                style: AppTextStyles.body(fontSize: 12, color: AppColors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
